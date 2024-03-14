import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/auth_controller.dart';
import '../auth/home_screen.dart';
import '../bottom_nav_bar/create_event.dart';
import '../notification_screen/notification_screen.dart';
import '../profile/profile_screen.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView({Key? key}) : super(key: key);

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  int currentIndex = 0;
  String? userRole;
  List<Widget> widgetOption = [
    const HomeScreen(),
    const NotificationScreen(),
    const CreateEventView(),
    const OnlyProfileScreen(),
  ]; // Default widgets

  @override
  void initState() {
    super.initState();
    fetchUserRole();
  }

  void fetchUserRole() async {
    userRole = await Get.find<AuthController>().getUserRole();
    setState(() {
      widgetOption = userRole == "Organizer"
          ? [
              const HomeScreen(),
              const NotificationScreen(),
              const CreateEventView(),
              const OnlyProfileScreen(),
            ]
          : [
              const HomeScreen(),
              const NotificationScreen(),
              const OnlyProfileScreen(),
            ];
    });
  }

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped,
        selectedItemColor: Colors.black,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Image.asset(
                currentIndex == 0
                    ? 'assets/Group 43 (1).png'
                    : 'assets/Group 43.png',
                width: 22,
                height: 22,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Image.asset(
                currentIndex == 1
                    ? 'assets/Group 18340 (1).png'
                    : 'assets/Group 18340.png',
                width: 22,
                height: 22,
              ),
            ),
            label: '',
          ),
          if (userRole == "Organizer")
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Image.asset(
                  currentIndex == 2
                      ? 'assets/Group 18528 (1).png'
                      : 'assets/Group 18528.png',
                  width: 22,
                  height: 22,
                ),
              ),
              label: '',
            ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Image.asset(
                currentIndex == 3
                    ? 'assets/Group 18341 (1).png'
                    : 'assets/Group 18341.png',
                width: 22,
                height: 22,
              ),
            ),
            label: '',
          ),
        ],
      ),
      body: widgetOption[currentIndex],
    );
  }
}
