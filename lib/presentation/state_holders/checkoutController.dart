import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/presentation/state_holders/cart_list_controller.dart';
import 'package:commerce/presentation/state_holders/homecontroller.dart';
import 'package:commerce/presentation/ui/screen/successfulorder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';

class Checkoutcontroller extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final cartctr = Get.put(CartListController());
  final db = FirebaseFirestore.instance;
  final _homecontrol = Get.put(HomeController());

  pay(double amount) async {
    final uniqueTransRef = PayWithPayStack().generateUuidV4();

    PayWithPayStack().now(
        context: Get.context as BuildContext,
        secretKey: "sk_test_3841acc7b3c03f7403e1fd92f534c05cbafabc4f",
        customerEmail: _auth.currentUser!.email ?? "",
        reference: uniqueTransRef,
        callbackUrl: "thefluxway.com",
        currency: "NGN",
        paymentChannel: [
          "card",
          "bank",
          "ussd",
          "qr",
          "mobile_money",
          "bank_transfer",
          "eft"
        ],
        amount: amount,
        transactionCompleted: () {
          Get.to(() => OrderSuccessScreen());
        },
        transactionNotCompleted: () {
          log("Transaction Not Successful!");
        });
  }

  orderSuccessful(
    amount,
    ref,
  ) {
    bool isSplit = cartctr.cart.length == 1 && cartctr.cart[0].split == true;
    List<String> items = [];
    for (var cart in cartctr.cart) {
      items.add(cart.name ?? "");
    }

    final data = {
      "Reference": ref,
      "Amount": amount,
      "Items": items,
      "Status": "processing",
      "Person1": _homecontrol.firstname,
      "Person1uid": _auth.currentUser!.uid,
      "Person2uid": "",
      "Fullypaid": isSplit ? false : true,
      "Split": isSplit,
      "data": cartctr.cart[0].toJson()
    };
    db
        .collection("orders")
        .doc(ref)
        .set(data, SetOptions(merge: true))
        .then((documentSnapshot) {
      Get.to(() => OrderSuccessScreen());
      cartctr.emtyCart();
    });
  }
}
