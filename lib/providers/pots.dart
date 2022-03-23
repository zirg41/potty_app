import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/providers/pot_set.dart';

class PotsCollection with ChangeNotifier {
  // final List<PotSet> _items = [
  //   PotSet(
  //     id: DateTime.now().toString(),
  //     name: "Зарплата (demo)",
  //     income: 32450,
  //     pots: [
  //       Pot(id: '1', name: "Основные расходы", percent: 55, amount: 17847.5),
  //       Pot(id: '2', name: "Ремонт", percent: 15, amount: 4867.5),
  //       Pot(id: '3', name: "Инвестиции", percent: 10, amount: 3245.0),
  //       Pot(id: '4', name: "Подарки", percent: 5, amount: 1622.5),
  //     ],
  //   ),
  //   PotSet(
  //     id: DateTime.now().toString(),
  //     name: "Аванс (demo)",
  //     income: 8674,
  //     pots: [
  //       Pot(id: '1', name: "Основные расходы", percent: 75, amount: 6505.5),
  //       Pot(id: '2', name: "Здоровье", percent: 10, amount: 867.4),
  //       Pot(id: '3', name: "Ремонт", percent: 10, amount: 867.4),
  //       Pot(id: '4', name: "Подарки", percent: 5, amount: 433.7),
  //     ],
  //   ),
  //   // PotSet(
  //   //   id: DateTime.now().toString(),
  //   //   name: "Зарплата",
  //   //   income: 29748,
  //   //   pots: [
  //   //     Pot(id: '1', name: "Основные расходы", percent: 55),
  //   //     Pot(id: '2', name: "Ремонт", percent: 15),
  //   //     Pot(id: '3', name: "Инвестиции", percent: 10),
  //   //     Pot(id: '4', name: "Подарки", percent: 5),
  //   //   ],
  //   // ),
  //   // PotSet(
  //   //   id: DateTime.now().toString(),
  //   //   name: "Зарплата3",
  //   //   income: 29748,
  //   //   pots: [],
  //   // ),
  // ];

  List<PotSet> _items = [];

  // PotsCollection(Box pots, Box potSet) {
  //   Map<String, dynamic> potSetMap = potSet.toMap();

  //   potSet.toMap().forEach((key, value) {
  //     _items.add(PotSet(
  //         id: key == 'id' ? value : null,
  //         income: key == 'income' ? value : null,
  //         name: key == 'name' ? value : null,
  //         pots: key == 'pots' ? value : null));
  //   });
  // }
  // final HiveList pots = HiveList(Hive.box("pots"), objects: []);
  // final HiveList potSets = HiveList(Hive.box("pots"), objects: []);

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
    definePotSet(potSetId).pots.forEach((pot) {
      if (!pot.isAmountFixed) {
        pot.amount = definePotSet(potSetId).income * pot.percent / 100;
      } else {
        pot.percent = pot.amount / definePotSet(potSetId).income * 100;
      }
    });

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

  HiveList<Pot> ad;
  String createPotSet(String name, double income) {
    final potSetId = DateTime.now().toString();
    _items.add(
      PotSet(
        id: potSetId,
        income: income,
        name: name,
        pots: [],
      ),
    );
    calculate(potSetId);
    notifyListeners();
    return potSetId;
  }
}
