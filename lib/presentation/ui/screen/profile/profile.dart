import 'package:commerce/presentation/state_holders/homecontroller.dart';
import 'package:commerce/presentation/ui/screen/auth/login.dart';
import 'package:commerce/presentation/ui/screen/profile/screen_title.dart';
import 'package:commerce/presentation/ui/screen/profile/settings_item.dart';
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
            ),
            SettingsItem(
              title: _homecontrol.email,
              icon: Icons.email,
            ),
            SettingsItem(
              title: _homecontrol.phone,
              icon: Icons.phone,
            ),
            SettingsItem(
              title: _homecontrol.address,
              icon: Icons.location_on,
            ),
            const SettingsItem(
              title: "Orders",
              icon: Icons.takeout_dining,
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
              child: const SettingsItem(
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
              child: const SettingsItem(
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
