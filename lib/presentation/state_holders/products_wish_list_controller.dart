import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/data/models/product/productModel.dart';
import 'package:commerce/data/models/products_model.dart';
import 'package:get/get.dart';

class ProductsWishListController extends GetxController {
  bool _getWishListInProgress = false;
  String _message = "";
  ProductModel _productModel = ProductModel();

  bool get getProductsWishListInProgress => _getWishListInProgress;

  ProductModel get productModel => _productModel;

  String get message => _message;
  final db = FirebaseFirestore.instance;
  List<NewProduct> wishlistproducts = [];

  getWishList() async {
    _getWishListInProgress = true;
    update();
    db.collection("wishlist").get().then(
      (querySnapshot) {
        List<NewProduct> temp = [];
        for (var docSnapshot in querySnapshot.docs) {
          temp.add(NewProduct.fromJson(docSnapshot.data()["productData"]));
          log('${docSnapshot.id} => ${docSnapshot.data()}');
        }
        wishlistproducts = temp;
        _getWishListInProgress = false;
        update();
        return true;
      },
      onError: (e) {
        _getWishListInProgress = false;
        update();
        print("Error completing: $e");
        return false;
      },
    );
  }
}
