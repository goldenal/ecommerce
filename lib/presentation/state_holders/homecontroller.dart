import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/data/models/product/orders.dart';
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
  List<OrdersModel> myyorders = [];
  List<OrdersModel> splitedorders = [];
  NewProduct? orderproduct;
  bool editing = false;

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

  fetchOrders() async {
    db.collection("orders").get().then(
      (querySnapshot) {
        List<OrdersModel> temp = [];
        for (var docSnapshot in querySnapshot.docs) {
          temp.add(OrdersModel.fromJson(docSnapshot.data()));
        }
        myyorders = temp.where((v) {
          return (v.person1Uid == _auth.currentUser!.uid ||
                  v.person2Uid == _auth.currentUser!.uid) &&
              v.fullypaid == true;
        }).toList();
        splitedorders = temp.where((v) {
          return v.fullypaid == false;
        }).toList();
        update();
      },
      onError: (e) => log("Error completing: $e"),
    );
  }

  editProfile(phone, address) async {
    editing = true;
    update();

    try {
      await db.collection('users').doc(_auth.currentUser!.uid).set(
          {'mobile': phone, 'shippingAddress': address},
          SetOptions(merge: true)); // Merge to avoid overwriting other fields
      editing = false;
      await fetchUserData();
      update();
      Get.back();
      return true;
    } catch (e) {
      editing = false;
      update();
      log('Error updating user information: $e');
      return false;
      // Handle error
    }
  }
}
