import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/providers/pot_set.dart';

class PotsCollection with ChangeNotifier {
  Box<PotSet> _potSetBox;

  List<PotSet> _items = [];

  PotsCollection(Box<PotSet> potset) {
    _potSetBox = potset;
    for (var element in potset.values) {
      _items.add(element);
    }
  }

  double percentSumm = 0.0;

  List<PotSet> get items {
    return [..._items];
  }

  PotSet definePotSet(String potSetId) {
    return _items.firstWhere((potSet) => potSet.id == potSetId);
  }

  void addPot(String potSetId, Pot newPot) {
    definePotSet(potSetId).pots.add(newPot);
    calculate(potSetId);
    notifyListeners();
  }

  void updatePot(String potSetId, String potId, Pot newPot) {
    final _currentPotSet = definePotSet(potSetId);

    final potIndex = _currentPotSet.pots.indexWhere(
      (pot) => pot.id == potId,
    );

    _currentPotSet.pots[potIndex] = newPot;

    calculate(potSetId);
  }

  void deletePot(String potSetId, String potId) {
    definePotSet(potSetId).pots.removeWhere((pot) => pot.id == potId);
    notifyListeners();
  }

  void calculate(String potSetId) {
    final _currentPotSet = definePotSet(potSetId);

    for (var pot in _currentPotSet.pots) {
      if (!pot.isAmountFixed) {
        pot.amount = _currentPotSet.income * pot.percent / 100;
      } else {
        pot.percent = pot.amount / _currentPotSet.income * 100;
      }
    }

    checkPots(potSetId);
    _sortPots(potSetId);
    savePotSetToMemory(definePotSet(potSetId));
    notifyListeners();
  }

  void _sortPots(String potSetId) {
    definePotSet(potSetId)
        .pots
        .sort((potA, potB) => potB.percent.compareTo(potA.percent));
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
    final _currentPotSet = definePotSet(potSetId);

    for (var pot in _currentPotSet.pots) {
      percentSumm += pot.percent;
    }

    double subtracPercent = (100 - percentSumm);

    _currentPotSet.unallocatedPercent = subtracPercent;

    _currentPotSet.unallocatedAmount =
        _currentPotSet.income * subtracPercent / 100;

    percentSumm = 0.0;
  }

  void changeIncome(String potSetId, double newIncome) {
    definePotSet(potSetId).income = newIncome;
    calculate(potSetId);
    notifyListeners();
  }

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

  void savePotSetToMemory(PotSet potSet) async {
    await _potSetBox.put(potSet.id, potSet);
  }

  void deletePotSetFromMemory(String potSetId) async {
    await definePotSet(potSetId).delete();
    _items.removeWhere((element) => element.id == potSetId);
    notifyListeners();
  }
}
