import 'package:flutter/material.dart';

class OnlyProfileScreen extends StatelessWidget {
  const OnlyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Profile',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
