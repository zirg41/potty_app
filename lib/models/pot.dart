import 'package:flutter/cupertino.dart';

class Pot {
  String name;
  double percent;
  double amount;
  String id;

  Pot({
    @required this.name,
    @required this.percent,
    this.amount,
    this.id,
  });
}
