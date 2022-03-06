import 'package:flutter/cupertino.dart';
import 'package:potty_app/models/pot.dart';

class PotSet with ChangeNotifier {
  final String id;
  final double income;
  final String name;
  final List<Pot> pots;
  double unallocatedAmount = 0;

  PotSet({
    @required this.id,
    @required this.income,
    @required this.name,
    @required this.pots,
  });
}
