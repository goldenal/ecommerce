import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/data/models/product/productModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';

class AddToCartController extends GetxController {
  bool _addToCartInProgress = false;
  String _message = '';
  final db = FirebaseFirestore.instance;

  bool get addToCartInProgress => _addToCartInProgress;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get message => _message;
  List<String> cart = [];

  Future<bool> addToCart(NewProduct product) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        _addToCartInProgress = true;
        update();

        final data = {
          "cart": product.toJson(),
          "uid": user.uid,
          "productId": product.id
        };
        db.collection("cart").add(data).then((documentSnapshot) =>
            print("Added Data with ID: ${documentSnapshot.id}"));

        _addToCartInProgress = false;
        update();
        return true;
      } catch (e) {
        return false;
        // TODO
      }
    } else {
      Get.snackbar("Error", "you need to login");
      return false;
    }
  }

  addMoreItems() {
    final uniqueTransRef = PayWithPayStack().generateUuidV4();
    NewProduct np = NewProduct(
      category: "Electronics",
      stock: "10",
      description: "Bag of ",
      id: uniqueTransRef,
      images: [""],
      name: "new item",
      price: generateRandomPrice.toString(),
      ratings: Ratings(average: "3.0", reviews: []),
    );
    db.collection("products").add(np.toJson()).then((documentSnapshot) =>
        print("Added Data with ID: ${documentSnapshot.id}"));
  }

  int generateRandomPrice({int minPrice = 0, int maxPrice = 1000}) {
    final random = Random();
    return minPrice + random.nextInt(maxPrice - minPrice + 1);
  }
}
