import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/data_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/events_feed_widget.dart';

class AdminIdentityVerificationPage extends StatefulWidget {
  const AdminIdentityVerificationPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AdminIdentityVerificationPageState createState() =>
      _AdminIdentityVerificationPageState();
}

class _AdminIdentityVerificationPageState
    extends State<AdminIdentityVerificationPage> {
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
                  "What Going on today",
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                EventsFeed(),
                Obx(() => dataController.isUsersLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : EventsIJoined())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
