import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_color.dart';
import '../view/notification_screen/notification_screen.dart';
import 'my_widgets.dart';

// ignore: non_constant_identifier_names
Widget CustomAppBar() {
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
                  fontSize: 16)),
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
          onTap: () {},
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
