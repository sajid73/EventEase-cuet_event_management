// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class DataController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  DocumentSnapshot? myDocument;

  var allUsers = <DocumentSnapshot>[].obs;
  var filteredUsers = <DocumentSnapshot>[].obs;
  var allEvents = <DocumentSnapshot>[].obs;
  var filteredEvents = <DocumentSnapshot>[].obs;
  var joinedEvents = <DocumentSnapshot>[].obs;

  var isEventsLoading = false.obs;

  Future<void> fetchCurrentUserDocument() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      myDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
    }
  }

  getJoinedEvents() {
    FirebaseFirestore.instance
        .collection('events')
        .where('joined', arrayContains: auth.currentUser!.uid)
        .get()
        .then((QuerySnapshot querySnapshot) {
      joinedEvents.value = querySnapshot.docs;
    });
  }

  Future<void> generateTicket(DocumentSnapshot event) async {
    print("Ticket generated");
    // Create a new PDF document
    PdfDocument document = PdfDocument();

    // Add a new page to the document
    PdfPage page = document.pages.add();

    // Create a new PDF graphics instance
    PdfGraphics graphics = page.graphics;

    // Set the font
    PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 12);

    // Draw the event details
    graphics.drawString(
      'Event Name: ${event.get('event_name')}',
      font,
      bounds: Rect.fromLTWH(0, 0, page.getClientSize().width, 20),
    );
    graphics.drawString(
      'Event Date: ${event.get('date').toString()}',
      font,
      bounds: Rect.fromLTWH(0, 20, page.getClientSize().width, 20),
    );
    graphics.drawString(
      'Event Tag: ${event.get('start_time')}',
      font,
      bounds: Rect.fromLTWH(0, 40, page.getClientSize().width, 20),
    );

    // Save the PDF document to a file
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/ticket.pdf');
    await file.writeAsBytes(await document.save());

    // Dispose the document
    document.dispose();
  }

  Future<String> uploadImageToFirebase(File file) async {
    String fileUrl = '';
    String fileName = Path.basename(file.path);
    var reference = FirebaseStorage.instance.ref().child('myfiles/$fileName');
    UploadTask uploadTask = reference.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      fileUrl = value;
    });
    return fileUrl;
  }

  Future<String> uploadThumbnailToFirebase(Uint8List file) async {
    String fileUrl = '';
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var reference =
        FirebaseStorage.instance.ref().child('myfiles/$fileName.jpg');
    UploadTask uploadTask = reference.putData(file);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      fileUrl = value;
    });

    return fileUrl;
  }

  Future<bool> createEvent(Map<String, dynamic> eventData) async {
    bool isCompleted = false;

    await FirebaseFirestore.instance
        .collection('events')
        .add(eventData)
        .then((value) {
      isCompleted = true;
      Get.snackbar('Event Uploaded', 'Event is uploaded successfully.',
          colorText: Colors.white, backgroundColor: Colors.blue);
    }).catchError((e) {
      isCompleted = false;
    });

    return isCompleted;
  }

  @override
  void onInit() {
    super.onInit();
    getUsers();
    getEvents();
    getJoinedEvents();
  }

  var isUsersLoading = false.obs;

  getUsers() {
    isUsersLoading(true);
    FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
      allUsers.value = event.docs;
      filteredUsers.value.assignAll(allUsers);
      isUsersLoading(false);
    });
  }

  getEvents() {
    isEventsLoading(true);

    FirebaseFirestore.instance.collection('events').snapshots().listen((event) {
      allEvents.assignAll(event.docs);
      filteredEvents.assignAll(event.docs);

      joinedEvents.value = allEvents.where((e) {
        List joinedIds = e.get('joined');

        return joinedIds.contains(FirebaseAuth.instance.currentUser!.uid);
      }).toList();

      isEventsLoading(false);
    });
  }
}
