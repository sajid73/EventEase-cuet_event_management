import 'package:cuet_event_management/view/onboarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'controller/data_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAOMqlASGKZFCRyPufSLViO8GG-5A1hFOo",
      appId: "com.example.cuet_event_management",
      messagingSenderId: "556153765882",
      projectId: "event-management-cuet",
    ),
  );
  Get.put(DataController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cuet Event Page',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      ),
      home: const OnBoardingScreen(),
    );
  }
}
