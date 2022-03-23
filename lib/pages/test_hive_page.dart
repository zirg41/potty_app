import 'package:flutter/material.dart';

class TestHivePage extends StatelessWidget {
  const TestHivePage();

  void doSomething() {
    // print("test");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test Hive Page")),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: doSomething,
      ),
    );
  }
}
