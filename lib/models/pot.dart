import 'package:flutter/foundation.dart';

class Pot {
  final String id;
  String name;
  double percent;
  double amount;
  bool isAmountFixed;

  Pot({
    @required this.id,
    @required this.name,
    this.percent,
    this.amount,
    this.isAmountFixed = false,
  });
}
