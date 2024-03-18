import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/data_controller.dart';
import '../utils/app_color.dart';
import '../view/event_page/event_page_view.dart';

// ignore: non_constant_identifier_names
Widget EventHome() {
  DataController dataController = Get.find<DataController>();

  return Obx(() => dataController.isEventsLoading.value
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, i) {
            final event = dataController.allEvents[i];
            // Check if the event is approved before displaying it
            if (event.get('approved') == true) {
              return EventItem(event);
            } else {
              return const SizedBox(); // Return an empty SizedBox for unapproved events
            }
          },
          itemCount: dataController.allEvents.length,
        ));
}

Widget buildCard(
    {String? image, text, Function? func, DocumentSnapshot? eventData}) {
  DataController dataController = Get.find<DataController>();

  List joinedUsers = [];

  try {
    joinedUsers = eventData!.get('joined');
  } catch (e) {
    joinedUsers = [];
  }

  List dateInformation = [];
  try {
    dateInformation = eventData!.get('date').toString().split('-');
  } catch (e) {
    dateInformation = [];
  }

  List userLikes = [];

  try {
    userLikes = eventData!.get('likes');
  } catch (e) {
    userLikes = [];
  }

  List eventSavedByUsers = [];
  try {
    eventSavedByUsers = eventData!.get('saves');
  } catch (e) {
    eventSavedByUsers = [];
  }

  return Container(
    padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(17),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 10, 2, 2).withOpacity(0.15),
          spreadRadius: 0.1,
          blurRadius: 2,
          offset: const Offset(0, 0), // changes position of shadow
        ),
      ],
    ),
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            func!();
          },
          child: Container(
            // child: Image.network(image!,fit: BoxFit.fill,),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(image!), fit: BoxFit.fill),
              borderRadius: BorderRadius.circular(10),
            ),

            width: double.infinity,
            height: Get.width * 0.5,
            //color: Colors.red,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: 41,
                height: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: const Color(0xffADD8E6))),
                child: Text(
                  '${dateInformation[0]}-${dateInformation[1]}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(
                width: 18,
              ),
              Text(
                text,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              const Spacer(),
              InkWell(
                onTap: () {
                  if (eventSavedByUsers
                      .contains(FirebaseAuth.instance.currentUser!.uid)) {
                    FirebaseFirestore.instance
                        .collection('events')
                        .doc(eventData!.id)
                        .set({
                      'saves': FieldValue.arrayRemove(
                          [FirebaseAuth.instance.currentUser!.uid])
                    }, SetOptions(merge: true));
                  } else {
                    FirebaseFirestore.instance
                        .collection('events')
                        .doc(eventData!.id)
                        .set({
                      'saves': FieldValue.arrayUnion(
                          [FirebaseAuth.instance.currentUser!.uid])
                    }, SetOptions(merge: true));
                  }
                },
                child: SizedBox(
                  width: 16,
                  height: 19,
                  child: Image.asset(
                    'assets/boomMark.png',
                    fit: BoxFit.contain,
                    color: eventSavedByUsers
                            .contains(FirebaseAuth.instance.currentUser!.uid)
                        ? Colors.red
                        : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
        Row(
          children: [
            const SizedBox(
              width: 68,
            ),
            InkWell(
              onTap: () {
                if (userLikes
                    .contains(FirebaseAuth.instance.currentUser!.uid)) {
                  FirebaseFirestore.instance
                      .collection('events')
                      .doc(eventData!.id)
                      .set({
                    'likes': FieldValue.arrayRemove(
                        [FirebaseAuth.instance.currentUser!.uid]),
                  }, SetOptions(merge: true));
                } else {
                  FirebaseFirestore.instance
                      .collection('events')
                      .doc(eventData!.id)
                      .set({
                    'likes': FieldValue.arrayUnion(
                        [FirebaseAuth.instance.currentUser!.uid]),
                  }, SetOptions(merge: true));
                }
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xffD24698).withOpacity(0.02),
                    )
                  ],
                ),
                child: Icon(
                  Icons.favorite,
                  size: 14,
                  color:
                      userLikes.contains(FirebaseAuth.instance.currentUser!.uid)
                          ? Colors.red
                          : Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 3,
            ),
            Text(
              '${userLikes.length}',
              style: TextStyle(
                color: AppColors.black,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ignore: non_constant_identifier_names
EventItem(DocumentSnapshot event) {
  DataController dataController = Get.find<DataController>();

  DocumentSnapshot user =
      dataController.allUsers.firstWhere((e) => event.get('uid') == e.id);

  String image = '';

  try {
    image = user.get('image');
  } catch (e) {
    image = '';
  }

  String eventImage = '';
  try {
    List media = event.get('media') as List;
    Map mediaItem =
        media.firstWhere((element) => element['isImage'] == true) as Map;
    eventImage = mediaItem['url'];
  } catch (e) {
    eventImage = '';
  }

  return Column(
    children: [
      Row(
        children: [
          InkWell(
            onTap: () {
              // Get.to(() => const ProfileScreen());
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              backgroundImage: NetworkImage(image),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            '${user.get('first')} ${user.get('last')}',
            style:
                GoogleFonts.raleway(fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ],
      ),
      SizedBox(
        height: Get.height * 0.01,
      ),
      buildCard(
          image: eventImage,
          text: event.get('event_name'),
          eventData: event,
          func: () {
            Get.to(() => EventPageView(event, user));
          }),
      const SizedBox(
        height: 15,
      ),
    ],
  );
}
