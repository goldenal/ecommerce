import 'package:commerce/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:commerce/presentation/ui/screen/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderSuccessScreen extends StatelessWidget {
  static const routeName = '/orderSuccess';

  @override
  Widget build(BuildContext context) {
    final navctr = Get.put(MainBottomNavController());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 3,
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 250,
              ),
            ),
            const Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    'Order Successfully',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Text(
                      'Thank you for the order Your order will be prepared and shipped by courier within 1-2 days',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: ElevatedButton(
                onPressed: () {
                  navctr.backToHomeScreen();
                  Get.offAll(() => const BottomNavBarScreen());
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: const Text('Continue Shopping'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
