import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/widgets/new_pot.dart';
import 'package:potty_app/widgets/pot_item.dart';
import 'package:potty_app/widgets/pot_list.dart';
import 'dart:core';

import 'widgets/input_income.dart';

void main() => runApp(const PottyApp());

class PottyApp extends StatelessWidget {
  const PottyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Potty',
      theme: ThemeData(
        primaryColor: const Color(0xFF264653),
        focusColor: const Color(0xFFE76F51),
        textTheme: const TextTheme(
          button: TextStyle(
            color: Color(0xFFf4f1de),
            //fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        accentColor: const Color(0xFF2a9d8f),
        //buttonColor: const Color(value),
        errorColor: const Color(0xFFc81d25),
        fontFamily: "Montserrat",
      ),
      home: const MyHomePage(title: 'Potty App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({@required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Pot> userPots = [
    Pot(name: "Основные расходы", percent: 65, id: DateTime.now().toString()),
    Pot(name: "Ремонт", percent: 10, id: DateTime.now().toString()),
    Pot(name: "Образование", percent: 5, id: DateTime.now().toString()),
    Pot(name: "Подарки", percent: 5, id: DateTime.now().toString()),
    Pot(name: "Инвестиции", percent: 5, id: DateTime.now().toString()),
    Pot(name: "Здоровье", percent: 5, id: DateTime.now().toString()),
  ];

  double percentSumm = 0;
  Pot unallocatedPot = Pot(
    name: "Нераспределенный",
    percent: 0,
    id: DateTime.now().toString(),
  );

  TextEditingController incomeField = TextEditingController();
  final emptyFieldSnackBar = const SnackBar(
    content: Text('Введите сумму дохода!'),
    duration: Duration(seconds: 1),
  );

  void calculate() {
    if (incomeField.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(emptyFieldSnackBar);
      return;
    }

    final double enteredIncome = double.parse(incomeField.text);
    setState(() {
      checkPots(userPots);
      for (var element in userPots) {
        element.amount = enteredIncome * element.percent / 100;
      }
      userPots.sort((potA, potB) => potB.percent.compareTo(potA.percent));
    });
  }

  void _startAddNewPot(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewPot(addNewPot: _addNewPot);
        });
  }

  void _editPot(BuildContext ctx, Pot pot) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewPot(
            addNewPot: _addNewPot,
            editingPot: pot,
            deleteOldPot: _deletePot,
          );
        });
  }

  void _addNewPot(String potName, double potPercent) {
    final Pot newPot = Pot(
      name: potName,
      percent: potPercent,
      id: DateTime.now().toString(),
    );
    setState(() {
      print("_addNewPot in main");
      userPots.add(newPot);
      calculate();
    });
  }

  void checkPots(List<Pot> checkingPot) {
    for (var element in checkingPot) {
      // summ of all percents in all items user added
      percentSumm += element.percent;
    }

    double subtracPercent = (100 - percentSumm).abs();
    debugPrint("subtracPercent: ${subtracPercent.toString()}%");

    double unallocatedAmount =
        double.parse(incomeField.text) * subtracPercent / 100;
    debugPrint("unallocatedAmount: ${unallocatedAmount.toString()} rubles");

    if (percentSumm == 100) {
      // if summ is 100 it's cool

      percentSumm = 0;
      unallocatedPot.percent = 0;
      return;
    }
    if (percentSumm < 100) {
      // some amount wasn't allocated

      unallocatedPot = Pot(
        // adding 100-summ
        // to separate Pot
        name: "Не распределено",
        percent: subtracPercent,
        amount: unallocatedAmount,
        id: DateTime.now().toString(),
      );
      //returning temporary var back to zero
      percentSumm = 0;
      return;
    }
    if (percentSumm > 100) {
      unallocatedPot = Pot(
        name: "Перераспределение",
        percent: subtracPercent,
        amount: unallocatedAmount,
        id: DateTime.now().toString(),
      );
      percentSumm = 0;
      return;
    }
  }

  void _deletePot(String id) {
    setState(() {
      userPots.removeWhere((element) {
        return element.id == id;
      });
      calculate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final mediaHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        mediaQuery.viewInsets.bottom;
    var pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 144,
              child: InputIncomeField(
                incomeField: incomeField,
                calculate: calculate,
              ),
            ),
            unallocatedPot.percent != 0
                ? Container(
                    //height: 100,
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: PotItem(pot: unallocatedPot),
                  )
                : const SizedBox.shrink(),
            Container(
              height: unallocatedPot.percent != 0
                  ? (mediaHeight - 290)
                  : (mediaHeight - 200),
              child: PotsList(
                pots: userPots,
                deleteItemFunc: _deletePot,
                editPotFunc: _editPot,
              ),
            )
          ],
        ),
      ),
    );

    var pageAppBar = AppBar(
      title: const Text("Potty"),
      backgroundColor: Theme.of(context).primaryColor,
    );

    var pageFloatingButton = FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => _startAddNewPot(context),
    );

    return Scaffold(
      appBar: pageAppBar,
      body: pageBody,
      floatingActionButton: pageFloatingButton,
    );
  }
}
