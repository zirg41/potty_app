import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/widgets/pot_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
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

  @override
  Widget build(BuildContext context) {
    var pageBody = Column(
      children: [
        Card(
          //color: Colors.blue,
          elevation: 5,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Введите доход, руб",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: incomeField,
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.fromLTRB(10, 10, 35, 10),
                child: FlatButton(
                  onPressed: calculate,
                  color: Theme.of(context).primaryColor,
                  child: const Text(
                    "Вычислить",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 500,
          padding: const EdgeInsets.all(8),
          child: PotsList(pots: userPots),
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Potty"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: pageBody,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => {},
      ),
    );
  }

  void calculate() {
    if (incomeField.text.isEmpty) return;
    final double enteredIncome = double.parse(incomeField.text);
    setState(() {
      for (var element in userPots) {
        element.amount = enteredIncome * element.percent / 100;
      }
    });
  }
}
