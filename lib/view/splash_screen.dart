import 'dart:async';

import 'package:cuet_event_management/view/auth/tab_control_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const TabControlScreen()));
    });

    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'Logo',
          child: Image.asset(
            'assets/Cuet_evento.png',
          ),
        ),
      ),
    );
  }
}
