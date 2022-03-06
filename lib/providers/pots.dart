import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/providers/pot_set.dart';

class PotsCollection with ChangeNotifier {
  final List<PotSet> _items = [
    PotSet(
      id: DateTime.now().toString(),
      name: "Зарплата",
      income: 32450,
      pots: [
        Pot(id: '1', name: "Основные расходы", percent: 55),
        Pot(id: '2', name: "Ремонт", percent: 15),
        Pot(id: '3', name: "Инвестиции", percent: 10),
        Pot(id: '4', name: "Подарки", percent: 5),
      ],
    ),
    PotSet(
      id: DateTime.now().toString(),
      name: "Аванс",
      income: 8674,
      pots: [
        Pot(id: '1', name: "Основные расходы", percent: 75),
        Pot(id: '2', name: "Здоровье", percent: 10),
        Pot(id: '3', name: "Ремонт", percent: 10),
        Pot(id: '4', name: "Подарки", percent: 5),
      ],
    ),
    PotSet(
      id: DateTime.now().toString(),
      name: "Зарплата",
      income: 29748,
      pots: [
        Pot(id: '1', name: "Основные расходы", percent: 55),
        Pot(id: '2', name: "Ремонт", percent: 15),
        Pot(id: '3', name: "Инвестиции", percent: 10),
        Pot(id: '4', name: "Подарки", percent: 5),
      ],
    ),
  ];

  double percentSumm;

  List<PotSet> get items {
    return [..._items];
  }

  PotSet _definePotSet(String potSetId) {
    return _items.firstWhere((potSet) => potSet.id == potSetId);
  }

  void addPot(String potSetId, Pot newPot) {
    _definePotSet(potSetId).pots.add(newPot);
    notifyListeners();
  }

  void deletePot(String potSetId, String potId) {
    _definePotSet(potSetId).pots.removeWhere((pot) => pot.id == potId);
    notifyListeners();
  }

  void calculate(String potSetId) {
    _definePotSet(potSetId).pots.forEach((pot) =>
        pot.amount = _definePotSet(potSetId).income * pot.percent / 100);
    checkPots(potSetId);
    notifyListeners();
  }

  void checkPots(String potSetId) {
    _definePotSet(potSetId).pots.forEach((pot) => percentSumm += pot.percent);
    double subtracPercent = (100 - percentSumm).abs();
    debugPrint("subtracPercent: ${subtracPercent.toString()}%");
    double unallocatedAmount =
        _definePotSet(potSetId).income * subtracPercent / 100;
    _definePotSet(potSetId).unallocatedAmount = unallocatedAmount;
    debugPrint("unallocatedAmount: ${unallocatedAmount.toString()} rubles");
    percentSumm = 0;
  }
}
