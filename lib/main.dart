import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/widgets/new_pot.dart';
import 'package:potty_app/widgets/pot_list.dart';

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
        textTheme: const TextTheme(
          button: TextStyle(
            color: Color(0xFFf4f1de),
            //fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        accentColor: const Color(0xFF2a9d8f),
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
    Pot(name: "Основные расходы", percent: 65),
    Pot(name: "Ремонт", percent: 10),
    Pot(name: "Образование", percent: 5),
    Pot(name: "Подарки", percent: 5),
    Pot(name: "Инвестиции", percent: 10),
    Pot(name: "Здоровье", percent: 5),
  ];

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
    ;
    final double enteredIncome = double.parse(incomeField.text);
    setState(() {
      for (var element in userPots) {
        element.amount = enteredIncome * element.percent / 100;
      }
    });
  }

  void _startAddNewPot(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewPot(addNewPot: _addNewPot);
        });
  }

  void _addNewPot(String potName, double potPercent) {
    final Pot newPot = Pot(
      name: potName,
      percent: potPercent,
    );
    setState(() {
      print("_addNewPot in main");
      userPots.add(newPot);
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
            Container(
              height: (mediaHeight - 140),
              child: PotsList(pots: userPots),
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
