import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/data/models/products_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DeleteCartListController extends GetxController {
  ProductModel _productModel = ProductModel();
  ProductModel get productModel => _productModel;
  String _message = '';
  String get message => _message;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
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
            update();
            Get.snackbar("success", "products deleted successfully");
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
