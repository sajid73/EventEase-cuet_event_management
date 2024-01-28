import 'package:flutter/material.dart';

class AdminIdentityVerificationPage extends StatelessWidget {
  const AdminIdentityVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please proof your identity',
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
