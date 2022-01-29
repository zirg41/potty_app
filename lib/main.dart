import 'package:flutter/material.dart';

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
  TextEditingController incomeField = TextEditingController();
  TextEditingController firstPotController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var body = Column(
      children: [
        Card(
          //color: Colors.blue,
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Введите доход, руб",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: incomeField,
                ),
              ],
            ),
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          padding: const EdgeInsets.fromLTRB(10, 10, 35, 10),
          child: FlatButton(
            onPressed: () {
              print("Field: ${incomeField.text}");
            },
            color: Theme.of(context).primaryColor,
            child: const Text(
              "Вычислить",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [PotWidget(firstPotController: firstPotController)],
          ),
        )
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Potty"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: body,
    );
  }

  Map<double, double> pots = {};
}

class PotWidget extends StatelessWidget {
  const PotWidget({
    @required this.firstPotController,
  });

  final TextEditingController firstPotController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text("Основные расходы (10%)"),
        Flexible(
            fit: FlexFit.tight,
            child: TextField(
              controller: firstPotController,
            ))
      ],
    );
  }
}
