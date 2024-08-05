import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/presentation/ui/screen/main_bottom_nav_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CompleteProfileController extends GetxController {
  bool _completeProfileInProgress = false;
  String _errorMessage = '';

  bool get completeProfileInProgress => _completeProfileInProgress;

  String get errorMessage => _errorMessage;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> getCompleteProfile(String firstName, String lastName,
      String mobile, String city, String shippingAddress) async {
    _completeProfileInProgress = true;
    update();
    final user = _auth.currentUser;
    if (user != null) {
      final uid = user.uid;

      try {
        await _firestore.collection('users').doc(uid).set({
          'firstName': firstName,
          'uid': uid,
          'lastName': lastName,
          'mobile': mobile,
          'city': city,
          'shippingAddress': shippingAddress
        }, SetOptions(merge: true)); // Merge to avoid overwriting other fields
        _completeProfileInProgress = false;
        update();
        Get.offAll(() => const BottomNavBarScreen());
        return true;
      } catch (e) {
        _completeProfileInProgress = false;
        update();
        log('Error updating user information: $e');
        return false;
        // Handle error
      }
    } else {
      log("mo");
      return false;
    }
  }
}
