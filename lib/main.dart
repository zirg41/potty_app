import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/widgets/new_pot.dart';
import 'package:potty_app/widgets/pot_list.dart';

import 'widgets/input_income.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Potty',
      theme: ThemeData(
        primaryColor: Colors.blue,
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
    Pot(name: "Основные расходы", percent: 55, amount: 26000),
    Pot(name: "Ремонт", percent: 10, amount: 4500),
  ];

  TextEditingController incomeField = TextEditingController();

  void calculate() {
    if (incomeField.text.isEmpty) return;
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

  void _addNewPot({String potName, double potPercent}) {
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

    var pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 180,
              child: InputIncomeField(
                incomeField: incomeField,
                calculate: calculate,
              ),
            ),
            Container(
              height: (mediaQuery.size.height -
                  mediaQuery.padding.top -
                  mediaQuery.viewInsets.bottom -
                  200),
              padding: const EdgeInsets.all(8),
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
