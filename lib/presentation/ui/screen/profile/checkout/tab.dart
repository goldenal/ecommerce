import 'package:flutter/material.dart';

class TabTitle extends StatelessWidget {
  final String title;
  final String actionText;
  final Function seeAll;
  final double padding;

  const TabTitle(
      {required this.title,
      required this.seeAll,
      this.actionText = 'See All',
      this.padding = 16});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          TextButton(
            onPressed: () {
              seeAll;
            },
            child: Text(
              actionText,
            ),
          ),
        ],
      ),
    );
  }
}
