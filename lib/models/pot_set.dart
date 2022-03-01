import 'package:flutter/cupertino.dart';
import 'package:potty_app/models/pot.dart';

class PotSet {
  final String name;
  final List<Pot> pots;

  PotSet({
    @required this.name,
    @required this.pots,
  });
}
