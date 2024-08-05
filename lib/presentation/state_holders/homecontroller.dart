import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/data/models/product/productModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _getProductsInProgress = false;
  final db = FirebaseFirestore.instance;
  String firstname = "", lastName = "", phone = "", email = "", address = "";
  List<NewProduct> products = [];
  bool get getProductsInProgress => _getProductsInProgress;
  isLoggedin() {
    final user = _auth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  fetchUserData() {
    final user = _auth.currentUser;
    if (user != null) {
      final docRef = db.collection("users").doc(user.uid);
      docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          // log("$data");
          firstname = data["firstName"];
          lastName = data["lastName"];
          address = data["shippingAddress"];
          phone = data["mobile"];
          email = user.email ?? "";
          update();
          // ...
        },
        onError: (e) => print("Error getting document: $e"),
      );
    }
  }

  fetchProducts() async {
    db.collection("products").get().then(
      (querySnapshot) {
        List<NewProduct> temp = [];
        for (var docSnapshot in querySnapshot.docs) {
          temp.add(NewProduct.fromJson(docSnapshot.data()));
          log('${docSnapshot.id} => ${docSnapshot.data()}');
        }
        products = temp;
      },
      onError: (e) => print("Error completing: $e"),
    );
  }
}
