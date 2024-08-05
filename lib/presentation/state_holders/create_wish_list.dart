import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/data/models/product/productModel.dart';
import 'package:commerce/data/models/products_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CreateWishListController extends GetxController {
  bool _getCreateWishListInProgress = false;
  String _message = "";
  ProductModel _productModel = ProductModel();

  bool get getCreateWishListInProgress => _getCreateWishListInProgress;

  ProductModel get productModel => _productModel;

  String get message => _message;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createWishList(String itemId,NewProduct np) async {
    _getCreateWishListInProgress = true;
    update();
    final user = _auth.currentUser;
    if (user != null) {
      final uid = user.uid;
      try {
        await _firestore.collection('wishlist').doc(itemId+uid).set({
          'uid': uid,
          'itemId': itemId,
         'productData':np.toJson()

        }, SetOptions(merge: true)); // Merge to avoid overwriting other fields
        _getCreateWishListInProgress = false;
        update();
        Get.snackbar("Sucess", "Added to wishlist");
        log('done');

        return true;
      } catch (e) {
        _getCreateWishListInProgress = false;
        update();
        log('Error adding wishlist: $e');
        return false;
        // Handle error
      }
    } else {
      Get.snackbar("error", "you need to login");
      return false;
    }
  }
}
