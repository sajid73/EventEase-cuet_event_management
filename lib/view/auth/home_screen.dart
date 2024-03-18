import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/data_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/main_event_feed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DataController dataController = Get.find<DataController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(),
                Text(
                  "What's Going on Today",
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                Obx(() {
                  if (dataController.isEventsLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    // Check if any event is approved
                    bool isEventApproved = dataController.allEvents.any(
                      (event) => event.get('approved') == true,
                    );
                    return isEventApproved ? EventHome() : Container();
                  }
                }),
                SizedBox(height: Get.height * 0.02),
                // Obx(() => dataController.isUsersLoading.value
                //     ? const Center(
                //         child: CircularProgressIndicator(),
                //       )
                //     : EventsIJoined()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
