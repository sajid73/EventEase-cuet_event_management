import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/data_controller.dart';
import '../utils/app_color.dart';

// Widget to display events feed
// ignore: non_constant_identifier_names
Widget EventsFeed() {
  DataController dataController = Get.find<DataController>();

  return Obx(() => dataController.isEventsLoading.value
      ? const Center(
          child: CircularProgressIndicator(),
        )
      : ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (ctx, i) {
            return EventItem(dataController.allEvents[i]);
          },
          itemCount: dataController.allEvents.length,
        ));
}

// Widget to display individual event item
// ignore: non_constant_identifier_names
Widget EventItem(DocumentSnapshot event) {
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

  List dateInformation = [];
  try {
    dateInformation = event.get('date').toString().split('-');
  } catch (e) {
    dateInformation = [];
  }

  return Column(
    children: [
      Row(
        children: [
          InkWell(
            onTap: () {
              // Navigate to user profile page
              // Get.to(() => ProfileScreen());
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
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ],
      ),
      SizedBox(
        height: Get.height * 0.01,
      ),
      buildCard(
        image: eventImage,
        eventName: event.get('event_name'),
        date: '${dateInformation[0]}-${dateInformation[1]}',
        startTime: event.get('start_time'),
        endTime: event.get('end_time'),
        description: event.get('description'),
        tags: event.get('tags'),
        approved: event.get('approved'),
        func: () {
          // Handle event approval
          bool isApproved = !event.get('approved');
          event.reference.update({'approved': isApproved});
          String message = isApproved ? 'Event Approved' : 'Event Rejected';
          Get.snackbar('Approval Status', message);
        },
      ),
      const SizedBox(
        height: 15,
      ),
    ],
  );
}

// Widget to build event card
Widget buildCard({
  required String image,
  required String eventName,
  required String date,
  required String startTime,
  required String endTime,
  required String description,
  required List<dynamic> tags,
  required bool approved,
  required Function func,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 10),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(17),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 23, 19, 19).withOpacity(0.15),
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
            func();
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            height: Get.width * 0.5,
          ),
        ),
        const SizedBox(height: 10),
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
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 6, 7),
                  ),
                ),
                child: Text(
                  date,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Text(
                eventName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => func(),
                child: Text(
                  approved ? 'Approved' : 'Pending',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const SizedBox(width: 68),
            Text(
              'Start Time: $startTime',
              style: const TextStyle(fontSize: 12),
            ),
            const Spacer(),
            Text(
              'End Time: $endTime',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Description: $description',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              const Text(
                'Tags: ',
                style: TextStyle(fontSize: 12),
              ),
              Row(
                children: tags.map((tag) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[100],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      tag.toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
