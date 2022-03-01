import 'package:flutter/cupertino.dart';
import 'package:potty_app/models/pot.dart';

class PotSet {
  final String id;
  final double income;
  final String name;
  final List<Pot> pots;

  PotSet({
    @required this.id,
    @required this.income,
    @required this.name,
    @required this.pots,
  });
}
