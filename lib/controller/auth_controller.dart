import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuet_event_management/view/auth/login_signup.dart';
import 'package:cuet_event_management/view/bottom_nav_bar/bottom_bar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as Path;

import '../view/auth/admin_identity_check.dart';
import '../view/profile/create_profile.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  void login({String? email, String? password}) {
    isLoading(true);

    auth
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) async {
      isLoading(false);

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(value.user!.uid)
          .get();
      String? role = userDoc.get('role');

      // Check the role and navigate accordingly
      if (role == "Administrator") {
        Get.to(() => const AdminIdentityVerificationPage());
      } else {
        Get.to(() => const BottomBarView());
      }
    }).catchError((e) {
      ///Error
      isLoading(false);
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'wrong-password':
            Get.snackbar('Error', 'Wrong password');
            break;
          case 'invalid-email':
            Get.snackbar('Error', 'Invalid email');
            break;
          case 'user-not-found':
            Get.snackbar('Error', 'No user found for that email.');
            break;
          default:
            Get.snackbar(
                'Error', 'An unknown error occurred. Please try again later.');
        }
      } else {
        Get.snackbar('Error', "$e");
      }
    });
  }

  void signUp({String? email, String? password}) {
    isLoading(true);

    auth
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      /// Navigate user to profile screen
      isLoading(false);
      Get.to(() => const ProfileScreen());
    }).catchError((e) {
      /// print error information
      Get.snackbar('Error', "$e");
      isLoading(false);
    });
  }

  void forgetPassword(String email) {
    auth.sendPasswordResetEmail(email: email).then((value) {
      Get.back();
      Get.snackbar('Email Sent', 'We have sent password reset email');
    }).catchError((e) {
      print("Error in sending password reset email is $e");
    });
  }

  void logout() {
    auth.signOut();
    Get.offAll(() => const LoginView());
  }

  void joinEvent(String eventId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    // Update the user's document with the joined event UID
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'joinedEvents': FieldValue.arrayUnion([eventId]),
    });
  }

  var isProfileInformationLoading = false.obs;

  Future<String> getUserRole() async {
    String? role;
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get();
      role = userDoc.get('role');
    } catch (e) {
      print("Error fetching user role: $e");
    }
    return role ?? '';
  }

  Future<String> uploadImageToFirebaseStorage(File image) async {
    String imageUrl = '';
    String fileName = Path.basename(image.path);

    var reference =
        FirebaseStorage.instance.ref().child('profileImages/$fileName');
    UploadTask uploadTask = reference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    await taskSnapshot.ref.getDownloadURL().then((value) {
      imageUrl = value;
    }).catchError((e) {
      print("Error happen $e");
    });

    return imageUrl;
  }

  uploadProfileData(String imageUrl, String firstName, String lastName,
      String mobileNumber, String dob, String gender, String role) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'image': imageUrl,
      'first': firstName,
      'last': lastName,
      'dob': dob,
      'gender': gender,
      'role': role
    }).then((value) {
      isProfileInformationLoading(false);
      switch (role) {
        case "Administrator":
          Get.offAll(() => const AdminIdentityVerificationPage());
          break;
        case "Organizer":
          Get.offAll(() => const BottomBarView());
          break;
        case "Participant":
          Get.offAll(() => const BottomBarView());
          break;
        default:
          break;
      }
    });
  }
}
