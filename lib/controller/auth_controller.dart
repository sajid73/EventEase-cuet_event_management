import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuet_event_management/view/bottom_nav_bar/bottom_bar_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../view/auth/admin_identity_check.dart';
import '../view/profile/create_profile.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  void login({String? email, String? password}) {
    isLoading(true);

    auth
        .signInWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      /// Login Success
      isLoading(false);
      Get.to(() => const BottomBarView());
    }).catchError((e) {
      ///Error
      isLoading(false);
      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'wrong-password':
            Get.snackbar('Error', 'Wrong password');
            break;
          case 'invalid-email':
            Get.snackbar('Error', 'Invalid email');
            break;
          case 'user-not-found':
            Get.snackbar('Error', 'No user found for that email.');
            break;
          default:
            Get.snackbar(
                'Error', 'An unknown error occurred. Please try again later.');
        }
      } else {
        Get.snackbar('Error', "$e");
      }
    });
  }

  void signUp({String? email, String? password}) {
    isLoading(true);

    auth
        .createUserWithEmailAndPassword(email: email!, password: password!)
        .then((value) {
      /// Navigate user to profile screen
      isLoading(false);
      Get.to(() => const ProfileScreen());
    }).catchError((e) {
      /// print error information
      Get.snackbar('Error', "$e");
      isLoading(false);
    });
  }

  void forgetPassword(String email) {
    auth.sendPasswordResetEmail(email: email).then((value) {
      Get.back();
      Get.snackbar('Email Sent', 'We have sent password reset email');
    }).catchError((e) {
      print("Error in sending password reset email is $e");
    });
  }

  var isProfileInformationLoading = false.obs;

  uploadProfileData(String firstName, String lastName, String mobileNumber,
      String dob, String gender, String role) {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection('users').doc(uid).set({
      'first': firstName,
      'last': lastName,
      'dob': dob,
      'gender': gender,
      'role': role
    }).then((value) {
      isProfileInformationLoading(false);
      switch (role) {
        case "Administrator":
          Get.offAll(() => const AdminIdentityVerificationPage());
          break;
        case "Organizer":
          Get.offAll(() => const BottomBarView());
          break;
        case "Participant":
          Get.offAll(() => const BottomBarView());
          break;
        default:
          break;
      }
    });
  }
}
