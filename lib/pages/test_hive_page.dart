import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/pages/pots_collection_page.dart';
import 'package:potty_app/providers/pot_set.dart';

class TestHivePage extends StatelessWidget {
  TestHivePage() {
    Hive.initFlutter();
    potSetBox = Hive.box<PotSet>("pot_sets");
    potsBox = Hive.box<Pot>("testbox");
  }
  Box<PotSet> potSetBox;
  Box<Pot> potsBox;
  final plainListOfPots = [
    Pot(
      id: DateTime.now().toString(),
      name: 'категория1',
      amount: 1000,
      isAmountFixed: false,
      percent: 10,
    ),
    Pot(
      id: DateTime.now().toString(),
      name: 'категория2',
      amount: 2000,
      isAmountFixed: false,
      percent: 20,
    ),
  ];
  void addPotToBox() async {
    // await box.put('name', 'Alina');

    // await potsBox.addAll(
    //   [
    //     Pot(
    //       id: DateTime.now().toString(),
    //       name: 'категория1',
    //       amount: 1000,
    //       isAmountFixed: false,
    //       percent: 10,
    //     ),
    //     Pot(
    //       id: DateTime.now().toString(),
    //       name: 'категория2',
    //       amount: 2000,
    //       isAmountFixed: false,
    //       percent: 20,
    //     ),
    //   ],
    // );
    // final str = potsBox.values as List<Pot>;

    // print(str[1].name);

    final potsList = HiveList<Pot>(Hive.box<Pot>("testbox"));

    // print(potsList[1].name);

    potSetBox.put(
      DateTime.now().toString(),
      PotSet(
        id: DateTime.now().toString(),
        income: 10000,
        name: "ZP",
        pots: plainListOfPots,
      ),
    );

    print(potSetBox.values.first.pots.first?.name);
    // final potsMap = testBox.toMap();
    // pots = testBox.toMap().values.toList();

    // potsMap.forEach((key, value) {
    //   print('Key: $key, Amount: ${value.amount}, setId: ${value.id}');
    // });

    // print();
    // testBox.deleteAll(['pots']);
  }

  void _deleteBox(Box box) {
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
            onPressed: () => _deleteBox(potSetBox),
            icon: const Icon(Icons.delete),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<PotSet>("pot_sets").listenable(),
        builder: (BuildContext context, Box<PotSet> box, Widget child) {
          return ListView(
              children: box
                  .toMap()
                  .values
                  .toList()
                  .map((e) => Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            "Наименовение: ${e.name} \nСумма: ${e.income}\nPots: ${e.pots.isEmpty ? "empty" : e.pots}\nID:${e.id}"),
                        // child: Text(
                        //     "Наименовение: ${e.name} \nСумма: ${e.amount}\nПроценты: ${e.percent}\nID:${e.id}"),
                      ))
                  .toList());
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: addPotToBox,
      ),
    );
  }
}
