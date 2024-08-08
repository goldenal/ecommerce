// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get_connect/http/src/utils/utils.dart';

OrdersModel ordersModelFromJson(String str) =>
    OrdersModel.fromJson(json.decode(str));

String ordersModelToJson(OrdersModel data) => json.encode(data.toJson());

class OrdersModel {
  String? reference;
  String? amount;
  List<String>? items;
  String? status;
  String? person1;
  String? person1Uid;
  String? person2Uid;
  bool? fullypaid;
  String? time;
  bool? split;

  OrdersModel({
    this.reference,
    this.amount,
    this.items,
    this.status,
    this.person1,
    this.person1Uid,
    this.person2Uid,
    this.fullypaid,
    this.split,
    this.time
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        reference: json["Reference"],
        amount: json["Amount"].toString(),
        items: json["Items"] == null
            ? []
            : List<String>.from(json["Items"]!.map((x) => x)),
        status: json["Status"],
        person1: json["Person1"],
        person1Uid: json["Person1uid"],
        person2Uid: json["Person2uid"],
        fullypaid: json["Fullypaid"],
        split: json["Split"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "Reference": reference,
        "Amount": amount,
        "Items": items == null ? [] : List<dynamic>.from(items!.map((x) => x)),
        "Status": status,
        "Person1": person1,
        "Person1uid": person1Uid,
        "Person2uid": person2Uid,
        "Fullypaid": fullypaid,
        "Split": split,
        "time":time
      };
}
