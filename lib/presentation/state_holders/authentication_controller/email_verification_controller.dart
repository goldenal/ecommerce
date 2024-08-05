import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class EmailVerificationController extends GetxController {
  bool _emailVerificationInProgress = false;
  String _message = '';

  bool get emailVerificationInProgress => _emailVerificationInProgress;

  String get message => _message;

  Future<bool> signUp(String email, String password) async {
    try {
      _emailVerificationInProgress = true;
      update();
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _emailVerificationInProgress = false;
      update();
      return true;
    } on FirebaseAuthException catch (e) {
      _emailVerificationInProgress = false;
      update();
      if (e.code == 'weak-password') {
        Get.snackbar("Error", 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar("Error", 'The account already exists for that email.');
      }
      return false;
    } catch (e) {
      _emailVerificationInProgress = false;
      update();
      log(e.toString());
      return false;
    }
  }

  Future<bool> login(emailAddress, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return false;
      }
      return false;
    }
  }
}
