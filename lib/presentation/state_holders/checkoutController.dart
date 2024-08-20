import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:commerce/presentation/state_holders/cart_list_controller.dart';
import 'package:commerce/presentation/state_holders/homecontroller.dart';
import 'package:commerce/presentation/ui/screen/main_bottom_nav_screen.dart';
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

  Future<void> pay(double amount, bool split, bool buysplit,
      {String? ref}) async {
    final uniqueTransRef = PayWithPayStack().generateUuidV4();

    await PayWithPayStack().now(
        context: Get.context as BuildContext,
        secretKey: "sk_test_3841acc7b3c03f7403e1fd92f534c05cbafabc4f",
        customerEmail: _auth.currentUser!.email ?? "",
        reference: uniqueTransRef,
        callbackUrl: "",
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
          log("Transaction  Successful!");

          Get.back();
          Future.delayed(Duration.zero, () {
            Get.to(() => OrderSuccessScreen());
          });
          if (buysplit) {
            log("Transaction  1!");
            buysplitSucess(ref);
          } else {
            log("Transaction  2!");
            orderSuccessful(amount, uniqueTransRef, split);
          }
        },
        transactionNotCompleted: () {
          log("Transaction Not Successful!");
        });
  }

  orderSuccessful(amount, ref, split) {
    bool isSplit =
        (cartctr.cart.length == 1 && cartctr.cart[0].split == true) && split;
    List<String> items = [];
    for (var cart in cartctr.cart) {
      items.add(cart.name ?? "");
    }

    final data = {
      "Reference": ref,
      "Amount": amount,
      "Items": items,
      "Status": isSplit ? "Pending" : "processing",
      "Person1": _homecontrol.firstname,
      "Person1uid": _auth.currentUser!.uid,
      "Person2uid": "",
      "Fullypaid": isSplit ? false : true,
      "Split": isSplit,
      "time": DateTime.now().toString(),
      "data": cartctr.cart[0].toJson()
    }; //
    db
        .collection("orders")
        .doc(ref)
        .set(data, SetOptions(merge: true))
        .then((documentSnapshot) {
      cartctr.emtyCart();
    });
  }

  buysplitSucess(ref) {
    final data = {
      "Reference": ref,
      "Status": "processing",
      "Person1": _homecontrol.firstname,
      "Person2uid": _auth.currentUser!.uid,
      "Fullypaid": true,
    };

    db
        .collection("orders")
        .doc(ref)
        .set(data, SetOptions(merge: true))
        .then((documentSnapshot) {
      Get.offAll(() => const BottomNavBarScreen()); //
    });
  }
}
