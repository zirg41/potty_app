import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/pages/pots_collection_page.dart';
import 'package:potty_app/providers/pot_set.dart';

class TestHivePage extends StatelessWidget {
  TestHivePage() {
    Hive.initFlutter();
    potSetBox = Hive.box<PotSet>("pot_sets");
  }

  Box<PotSet> potSetBox;

  final plainListOfPots = [
    Pot(
      id: DateTime.now().toString(),
      name: 'категория3',
      amount: 1000,
      isAmountFixed: false,
      percent: 10,
    ),
    Pot(
      id: DateTime.now().toString(),
      name: 'категория4',
      amount: 2000,
      isAmountFixed: false,
      percent: 20,
    ),
  ];
  void addPotToBox() async {
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
  }

  void _deleteBox(Box box) {
    box.clear();
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
                  .map((e) => Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                                "Наименовение: ${e.name} \nСумма: ${e.income}\nPots: ${e.pots.isEmpty ? "empty" : e.pots.toString()}\nID:${e.id}"),
                            // child: Text(
                            //     "Наименовение: ${e.name} \nСумма: ${e.amount}\nПроценты: ${e.percent}\nID:${e.id}"),
                          ),
                          IconButton(
                              onPressed: () => e.delete(),
                              icon: const Icon(Icons.delete))
                        ],
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
