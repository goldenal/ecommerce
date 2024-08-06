import 'package:commerce/presentation/state_holders/checkoutController.dart';
import 'package:commerce/presentation/ui/screen/profile/checkout/pricebreakdown.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  static const routeName = '/checkout';

  @override
  Widget build(BuildContext context) {
    final checkCtrl = Get.put(Checkoutcontroller());
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // CustomAppBar(
            //   'Checkout',
            //   [],
            // ),
            const Expanded(
              child: Column(
                children: [
                  // TabTitle(
                  //   title: 'Destination',
                  //   actionText: 'Change',
                  //   seeAll: null,
                  // ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DestinationCard(),
                        Divider(
                          height: 48,
                        ),
                        Text(
                          'Choose payment method',
                        ),
                        PaymentCard(
                          isSelected: true,
                          title: '**** 2456',
                        ),
                        PaymentCard(title: 'Apple pay'),
                        PaymentCard(title: 'Cash on delivery'),
                        Divider(
                          height: 56,
                        ),
                        PriceBreakdown(
                          title: 'Sub total Price',
                          price: '\$155',
                        ),
                        PriceBreakdown(
                          title: 'Delivery Fee',
                          price: '\$8',
                        ),
                        PriceBreakdown(
                          title: 'TanahAir Voucher',
                          price: 'None',
                        ),
                        PriceBreakdown(
                          title: 'Total price',
                          price: '\$163',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: ElevatedButton(
                onPressed: () {
                  checkCtrl.pay();
                  // Navigator.of(context).pushNamed(OrderSuccessScreen.routeName);
                },
                child: const Text('Pay Now'),
              ),
            ),
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
                fontSize: 17,
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
    return Container(
      height: 96,
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
                  'Shoo Phar Nhoe',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Flexible(
                  child: Text(
                    'Planet Namex, 989 Warhammer Street',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: const Color(0xFF8A8A8E),
                        ),
                    softWrap: true,
                  ),
                ),
                Text(
                  '(+78) 8989 8787',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: const Color(0xFF8A8A8E),
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
