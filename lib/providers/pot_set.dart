import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:potty_app/models/pot.dart';

part 'pot_set.g.dart';

@HiveType(typeId: 1)
class PotSet extends HiveObject with ChangeNotifier {
  @HiveField(0)
  final String id;

  @HiveField(1)
  double income;

  @HiveField(2)
  String name;

  @HiveField(3)
  HiveList pots;

  @HiveField(4)
  double unallocatedAmount = 0;

  @HiveField(5)
  double unallocatedPercent = 0;

  PotSet({
    @required this.id,
    @required this.income,
    @required this.name,
    @required this.pots,
  });
}
