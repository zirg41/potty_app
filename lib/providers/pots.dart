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
    PotSet(
      id: DateTime.now().toString(),
      name: "Зарплата3",
      income: 29748,
      pots: [],
    ),
  ];
  double percentSumm;

  List<PotSet> get items {
    return [..._items];
  }

  PotSet definePotSet(String potSetId) {
    return _items.firstWhere((potSet) => potSet.id == potSetId);
  }

  void addPot(String potSetId, Pot newPot) {
    definePotSet(potSetId).pots.add(newPot);
    notifyListeners();
  }

  void updatePot(String potSetId, String potId, Pot newPot) {
    final potIndex = definePotSet(potSetId).pots.indexWhere(
          (pot) => pot.id == potId,
        );
    definePotSet(potSetId).pots[potIndex] = newPot;
  }

  void deletePot(String potSetId, String potId) {
    definePotSet(potSetId).pots.removeWhere((pot) => pot.id == potId);
    notifyListeners();
  }

  void calculate(String potSetId) {
    definePotSet(potSetId).pots.forEach((pot) =>
        pot.amount = definePotSet(potSetId).income * pot.percent / 100);
    checkPots(potSetId);
    notifyListeners();
  }

  Pot calculatePercentBasedOnAmount(String potSetId, Pot amountPot) {
    double _currentIncome = definePotSet(potSetId).income;
    return Pot(
      id: amountPot.id,
      name: amountPot.name,
      amount: amountPot.amount,
      percent: amountPot.amount / _currentIncome * 100,
    );
  }

  void checkPots(String potSetId) {
    percentSumm = 0.0;
    definePotSet(potSetId).pots.forEach((pot) {
      percentSumm += pot.percent;
    });
    double subtracPercent = (100 - percentSumm);
    definePotSet(potSetId).unallocatedPercent = subtracPercent;
    // debugPrint("subtracPercent: ${subtracPercent.toString()}%");
    double unallocatedAmount =
        definePotSet(potSetId).income * subtracPercent / 100;
    definePotSet(potSetId).unallocatedAmount = unallocatedAmount;
    // debugPrint("unallocatedAmount: ${unallocatedAmount.toString()} rubles");
    percentSumm = 0.0;
  }

  void changeIncome(String potSetId, double newIncome) {
    definePotSet(potSetId).income = newIncome;
    calculate(potSetId);
    notifyListeners();
  }
}
