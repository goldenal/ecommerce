import 'package:commerce/presentation/state_holders/homecontroller.dart';
import 'package:commerce/presentation/ui/screen/auth/login.dart';
import 'package:commerce/presentation/ui/screen/profile/editProfile.dart';
import 'package:commerce/presentation/ui/screen/profile/orderhistory.dart';
import 'package:commerce/presentation/ui/screen/profile/screen_title.dart';
import 'package:commerce/presentation/ui/screen/profile/settings_item.dart';
import 'package:commerce/presentation/ui/screen/profile/splittedOrder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final _homecontrol = Get.put(HomeController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            const ScreenTitle(
              title: 'Settings',
              dividerEndIndent: 230,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                )),
            SettingsItem(
              title: _homecontrol.firstname + " " + _homecontrol.lastName,
              icon: Icons.person,
              isAccount: true,
              txt: _homecontrol.phone,
            ),
            SettingsItem(
              title: _homecontrol.email,
              icon: Icons.email,
              isAccount: true,
            ),
            GetBuilder<HomeController>(builder: (c) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => Editprofile())?.then((v) {
                    _homecontrol.update();
                  });
                },
                child: SettingsItem(
                  title: "Shipping address",
                  icon: Icons.location_on,
                  txt: _homecontrol.address,
                ),
              );
            }),
            GetBuilder<HomeController>(builder: (c) {
              return GestureDetector(
                onTap: () {
                  Get.to(() => Editprofile())?.then((v) {
                    _homecontrol.update();
                  });
                },
                child: SettingsItem(
                  title: "Phone",
                  icon: Icons.phone,
                  txt: _homecontrol.phone,
                ),
              );
            }),
            GestureDetector(
              onTap: () {
                Get.to(() => const OrderHistoryPage())?.then((v) {
                  _homecontrol.update();
                });
              },
              child: SettingsItem(
                title: "My Orders",
                icon: Icons.takeout_dining,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const Splittedorder());
              },
              child: SettingsItem(
                title: "Split Orders",
                icon: Icons.takeout_dining,
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => Editprofile())?.then((v) {
                  _homecontrol.update();
                });
              },
              child: SettingsItem(
                title: "Edit Profile",
                icon: Icons.edit,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                )),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                launchUrl(Uri.parse(
                    'https://tawk.to/chat/61ebeb499bd1f31184d8b9a7/1fq1o5bdo'));
              },
              child: SettingsItem(
                title: 'Live chat',
                icon: Icons.live_help,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Get.to(() => const Login());
              },
              child: SettingsItem(
                title: 'Sign Out',
                icon: Icons.logout,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
