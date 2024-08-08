import 'package:commerce/presentation/state_holders/cart_list_controller.dart';
import 'package:commerce/presentation/state_holders/checkoutController.dart';
import 'package:commerce/presentation/state_holders/homecontroller.dart';
import 'package:commerce/presentation/ui/screen/checkout/pricebreakdown.dart';
import 'package:commerce/presentation/ui/screen/successfulorder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    final checkCtrl = Get.put(Checkoutcontroller());
    final cart = Get.put(CartListController());

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // CustomAppBar(
            //   'Checkout',
            //   [],
            // ),
            Expanded(
              child: Column(
                children: [
                  // TabTitle(
                  //   title: 'Destination',
                  //   actionText: 'Change',
                  //   seeAll: null,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const DestinationCard(),
                        const Divider(
                          height: 48,
                        ),
                        const Text(
                          'Our supported payment method',
                        ),
                        const PaymentCard(
                          //  isSelected: true,
                          title: 'Card',
                        ),
                        const PaymentCard(title: 'Bank'),
                        const PaymentCard(title: 'USSD'),

                        const Divider(
                          height: 56,
                        ),
                        PriceBreakdown(
                          title: 'Sub total Price',
                          price: 'N${cart.totalPrice}',
                        ),
                        const PriceBreakdown(
                          title: 'Delivery Fee',
                          price: 'N500',
                        ),
                        // PriceBreakdown(
                        //   title: 'TanahAir Voucher',
                        //   price: 'None',
                        // ),
                        PriceBreakdown(
                          title: 'Total price',
                          price: 'N${cart.totalPrice + 500}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            if (cart.cart.length == 1 && cart.cart[0].split == true)
              ElevatedButton(
                onPressed: () {
                  checkCtrl.pay((cart.totalPrice / 2) + 500).then((_) {
                    Get.to(() => OrderSuccessScreen());
                  });
                  // Navigator.of(context).pushNamed(OrderSuccessScreen.routeName);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 40),
                  child: Text('Split with someone '),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                checkCtrl.pay(cart.totalPrice + 500).then((_) {
                  Get.to(() => OrderSuccessScreen());
                });
                // Navigator.of(context).pushNamed(OrderSuccessScreen.routeName);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 40),
                child: Text('Pay Now '),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text('Using our 5 different payment option '),
            const SizedBox(
              height: 4,
            ), //using our 5 different payment option
          ],
        ),
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    Key? key,
    this.isSelected = false,
    this.title,
  }) : super(key: key);

  final bool isSelected;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(
          8,
        ),
        boxShadow: [
          isSelected
              ? const BoxShadow(
                  color: Color(0x3322292E),
                  offset: Offset(
                    24,
                    40,
                  ),
                  blurRadius: 80,
                )
              : const BoxShadow(color: Colors.transparent),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: ShapeDecoration(
              color: const Color(0xFFE5E5EA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Text(
              title ?? "",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  const DestinationCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _homecontrol = Get.put(HomeController());
    return Container(
      height: 120,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: 80,
            decoration: ShapeDecoration(
              color: const Color(0xFFE5E5EA),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
              ),
            ),
            child: const Icon(
              Icons.home,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Delivery Address',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${_homecontrol.address.capitalizeFirst}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontSize: 20,
                        color: const Color(0xFF8A8A8E),
                      ),
                  softWrap: true,
                ),
                Text(
                  '${_homecontrol.phone}',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: const Color(0xFF8A8A8E),
                        fontSize: 20,
                      ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
