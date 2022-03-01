import 'package:flutter/foundation.dart';

class Pot {
  String id;
  String name;
  double percent;
  double amount;

  Pot({
    @required this.id,
    @required this.name,
    this.percent,
    this.amount,
  });
}
