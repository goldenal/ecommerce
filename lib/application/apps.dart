import 'dart:async';

import 'package:commerce/application/state_holders_bindings.dart';
import 'package:commerce/presentation/ui/screen/splash_screen.dart';
import 'package:commerce/presentation/ui/utils/app_color.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Commerce extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  const Commerce({super.key});

  @override
  State<Commerce> createState() => _CommerceState();
}

class _CommerceState extends State<Commerce> {
  late final StreamSubscription _connectivityStream;

  @override
  void initState() {
    checkInitialInternetConnection();
    checkInternetConnectivityStatus();
    super.initState();
  }

  void checkInitialInternetConnection() async {
    final result = await Connectivity().checkConnectivity();
    handleConnectivityStates(result);
  }

  void checkInternetConnectivityStatus() {}

  void handleConnectivityStates(ConnectivityResult status) {
    if (status != ConnectivityResult.mobile &&
        status != ConnectivityResult.wifi) {
      Get.showSnackbar(const GetSnackBar(
        title: 'No internet!',
        message: 'Please check your internet connectivity',
        isDismissible: false,
      ));
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeAllSnackbars();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(414, 896),
      minTextAdapt: true,
      // orientation: Orientation.portrait
    );
    return GetMaterialApp(
      navigatorKey: Commerce.globalKey,
      useInheritedMediaQuery: true, //for devices preview
      locale: DevicePreview.locale(context), //for devices preview
      builder: DevicePreview.appBuilder, //for devices preview
      initialBinding: StateHoldersBindings(),
      debugShowCheckedModeBanner: false,
      title: "commerce",
      home: const SplashScreen(),
      theme: ThemeData(
        primarySwatch:
            MaterialColor(AppColor.primaryColor.value, AppColor().color),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColor.primaryColor),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColor.primaryColor)),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.primaryColor),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
                fontSize: 16, letterSpacing: 2, fontWeight: FontWeight.w600),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 24),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _connectivityStream.cancel();
    super.dispose();
  }
}
