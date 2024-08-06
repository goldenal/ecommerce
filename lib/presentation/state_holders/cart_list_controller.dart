import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/data/models/cart_list_model.dart';
import 'package:commerce/data/models/product/productModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CartListController extends GetxController {
  bool _cartListInProgress = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  CartListModel _cartListModel = CartListModel();
  double _totalPrice = 0;
  String _message = '';
  List<NewProduct> cart = [];

  bool get cartListInProgress => _cartListInProgress;

  CartListModel get cartListModel => _cartListModel;

  double get totalPrice => _totalPrice;

  String get message => _message;
  final db = FirebaseFirestore.instance;

  Future<bool> getCartList() async {
    final user = _auth.currentUser;
    if (user != null) {
      _cartListInProgress = true;
      update();
      db.collection("cart").where("uid", isEqualTo: user.uid).get().then(
          (querySnapshot) {
        print("Successfully completed");
        List<NewProduct> tp = [];
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          tp.add(NewProduct.fromJson(docSnapshot.data()["cart"]));
        }
        cart = tp;
        _cartListInProgress = false;
        _calculateTotalPrice();
        update();
      }, onError: (e) {
        _cartListInProgress = false;
        update();
        print("Error completing: $e");
      });
      return true;
    } else {
      Get.snackbar("Error", "You need to login");
      return false;
    }
  }

  void changeItem(int cartId, int noOfItems) {
    _cartListModel.data
        ?.firstWhere((cartData) => cartData.id == cartId)
        .numberOfItems = noOfItems;
    _calculateTotalPrice();
  }

  void _calculateTotalPrice() {
    _totalPrice = 0;
    for (NewProduct data in cart) {
      log("<>${data.price}");
      _totalPrice += (double.parse(data.price ?? "0"));
    }
    update();
  }

  deleteCartId(String id) async {
    String docuId = "";
    final user = _auth.currentUser;

    db
        .collection("cart")
        .where("uid", isEqualTo: user!.uid)
        .where("productId", isEqualTo: id)
        .get()
        .then(
      (doc) {
        for (var docSnapshot in doc.docs) {
          log('${docSnapshot.id} => ${docSnapshot.data()}');
          docuId = docSnapshot.id;
        }
        db.collection("cart").doc(docuId).delete().then(
          (doc) {
            Get.snackbar("success", "products deleted successfully");
            getCartList();
          },
          onError: (e) => print("Error updating document $e"),
        );
      },
      onError: (e) => print("Error updating document $e"),
    );

    // if (response.isSuccess && response.statusCode == 200) {
    //   return true;
    // } else {
    //   _message = "delete cart list failed";
    //   return false;
    // }
  }
}
