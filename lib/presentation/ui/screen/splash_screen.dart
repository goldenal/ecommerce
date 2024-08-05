import 'package:commerce/presentation/state_holders/authentication_controller/auth_controller.dart';
import 'package:commerce/presentation/ui/screen/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToNextScreen();
    super.initState();
  }

  Future<void> goToNextScreen() async {
    await AuthController.getAccessToken();
    Future.delayed(const Duration(seconds: 3)).then(
        // (value) => Get.to(()=> const BottomNavBarScreen())
        (value) => AuthController.isLogin
            ? Get.offAll(const BottomNavBarScreen())
            : Get.offAll(const BottomNavBarScreen())
        //Get.to(() => const EmailVerificationScreen()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          // Center(
          //   child: SvgPicture.asset(ImagesUtils.craftyBayLogoSVG, width: 100),
          // ),
          Spacer(),
          CircularProgressIndicator(),
          Row(),
          SizedBox(
            height: 10,
          ),
          // const Text(
          //   "Developed By Mostafejur Rahman",
          //   style: TextStyle(
          //       color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 13),
          // ),
          SizedBox(
            height: 10,
          ),
          Text("Version 1.0.0"),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
