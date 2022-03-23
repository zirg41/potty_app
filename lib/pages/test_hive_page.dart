import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:potty_app/pages/pots_collection_page.dart';

class TestHivePage extends StatelessWidget {
  TestHivePage() {
    Hive.initFlutter();
  }

  void doSomething() {}

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
          )
        ],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: doSomething,
      ),
    );
  }
}
