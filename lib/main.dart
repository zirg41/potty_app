import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';
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
    Pot(name: "Образование", percent: 10, amount: 4500),
    Pot(name: "Инвестиции", percent: 10, amount: 4500),
    Pot(name: "Подарки", percent: 5, amount: 2250),
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
    showBottomSheet(context: ctx, builder: (_) {});
  }

  @override
  Widget build(BuildContext context) {
    var pageBody = Column(
      children: [
        InputIncomeField(
          incomeField: incomeField,
          calculate: calculate,
        ),
        Container(
          height: 500,
          padding: const EdgeInsets.all(8),
          child: PotsList(pots: userPots),
        )
      ],
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
