import 'package:flutter/cupertino.dart';
import 'package:potty_app/models/pot.dart';

class PotSet with ChangeNotifier {
  final String id;
  double income;
  String name;
  List<Pot> pots;
  double unallocatedAmount = 0;
  double unallocatedPercent = 0;

  PotSet({
    @required this.id,
    @required this.income,
    @required this.name,
    @required this.pots,
  });
}
