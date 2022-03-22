import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/pages/pots_collection_page.dart';

class TestHivePage extends StatelessWidget {
  TestHivePage() {
    Hive.initFlutter();
    testBox = Hive.box<Pot>('testbox');
  }
  var testBox;
  void doSomething() {
    // await box.put('name', 'Alina');

    testBox.put(
      DateTime.now().toString(),
      Pot(
        id: DateTime.now().toString(),
        name: 'категория4',
        amount: 4000,
        isAmountFixed: false,
        percent: 40,
      ),
    );
    // final potsMap = testBox.toMap();
    // pots = testBox.toMap().values.toList();

    // potsMap.forEach((key, value) {
    //   print('Key: $key, Amount: ${value.amount}, setId: ${value.id}');
    // });

    // print();
    // testBox.deleteAll(['pots']);
  }

  void _deleteBox(Box<Pot> box) {
    box.clear();
  }

  String _printPot(Pot pot) {
    return "PotId: ${pot.id} /nAmount: ${pot.amount}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Hive Page"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(PotsCollectionPage.routeName),
            icon: const Icon(Icons.exit_to_app_outlined),
          ),
          IconButton(
            onPressed: () => _deleteBox(testBox),
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Pot>('testbox').listenable(),
        builder: (BuildContext context, Box<Pot> box, Widget child) {
          return ListView(
              children: box
                  .toMap()
                  .values
                  .toList()
                  .map((e) => Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            "Наименовение: ${e.name} \nСумма: ${e.amount}\nПроценты: ${e.percent}\nID:${e.id}"),
                      ))
                  .toList());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: doSomething,
      ),
    );
  }
}
