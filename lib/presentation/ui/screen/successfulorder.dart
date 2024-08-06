import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  static const routeName = '/orderSuccess';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                child: Image.asset('assets/images/wallet_illu.png'),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: const Column(
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
                          color: Color(0xFF8A8A8E),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.of(context)
                  //     .pushReplacementNamed(TabScreen.routeName);
                },
                child: const Text('Continue Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
