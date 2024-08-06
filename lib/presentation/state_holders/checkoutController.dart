import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';

class Checkoutcontroller extends GetxController {
  pay() async {
    final uniqueTransRef = PayWithPayStack().generateUuidV4();

    PayWithPayStack().now(
        context: Get.context as BuildContext,
        secretKey: "sk_test_3841acc7b3c03f7403e1fd92f534c05cbafabc4f",
        customerEmail: "your@email.com",
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
        amount: 200,
        transactionCompleted: () {
          log("Transaction Successful");
        },
        transactionNotCompleted: () {
          log("Transaction Not Successful!");
        });
  }
}
