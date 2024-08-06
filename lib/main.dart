import 'package:commerce/application/apps.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission(provisional: true);
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  runApp(const Commerce());
}
