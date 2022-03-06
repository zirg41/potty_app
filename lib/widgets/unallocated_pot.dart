import 'package:flutter/material.dart';

class UnallocatedPot extends StatelessWidget {
  final double percent;
  final double amount;
  UnallocatedPot({
    @required this.percent,
    @required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Column(
        children: [
          Text(percent.toString()),
          Text(amount.toString()),
        ],
      ),
    );
  }
}
