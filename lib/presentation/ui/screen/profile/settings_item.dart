import 'package:commerce/presentation/state_holders/homecontroller.dart';
import 'package:commerce/presentation/ui/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isAccount;
  final bool isDark;
  const SettingsItem({
    Key? key,
    required this.title,
    required this.icon,
    this.isAccount = false,
    this.isDark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _homecontrol = Get.put(HomeController());
    final theme = context.theme;
    return ListTile(
      title: Text(title,
          style: theme.textTheme.displayMedium?.copyWith(
            fontSize: 16,
          )),
      subtitle: !isAccount
          ? null
          : Text(
              _homecontrol.phone,
            ),
      leading: CircleAvatar(
        radius: isAccount ? 20 : 20,
        backgroundColor: AppColor.primaryColor,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      trailing: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(
          Icons.arrow_forward_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
