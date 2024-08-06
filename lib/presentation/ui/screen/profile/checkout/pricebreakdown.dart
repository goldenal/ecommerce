import 'package:flutter/material.dart';

class PriceBreakdown extends StatelessWidget {
  const PriceBreakdown({
    Key? key,
    this.title,
    this.price,
  }) : super(key: key);

  final String? title;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title??"",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Color(0xFF8A8A8E),
              ),
        ),
        Spacer(),
        Text(
          price??"",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: Color(0xFF22292E),
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
