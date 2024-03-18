import 'package:cuet_event_management/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_color.dart';
import '../view/notification_screen/notification_screen.dart';
import 'my_widgets.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          SizedBox(
            width: 116,
            height: 17,
            child: myText(
                text: 'CUET EVENTS',
                style: TextStyle(
                    color: AppColors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
          ),
          const Spacer(),
          SizedBox(
            width: 24,
            height: 22,
            child: InkWell(
              onTap: () {
                Get.to(() => const NotificationScreen());
              },
              child: Image.asset('assets/Frame.png'),
            ),
          ),
          SizedBox(
            width: Get.width * 0.04,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const SideModal();
                },
              );
            },
            child: SizedBox(
              width: 22,
              height: 20,
              child: Image.asset(
                'assets/menu.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SideModal extends StatelessWidget {
  const SideModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.2, // Adjust the height as needed
      width: Get.width * 0.5, // Adjust the width as needed
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: InkWell(
              onTap: () {
                // Handle Home menu option
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.home),
                  SizedBox(width: 10),
                  Text(
                    'Home',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: InkWell(
              onTap: () {
                AuthController().logout();
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout),
                  SizedBox(width: 10),
                  Text(
                    'Log out',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
