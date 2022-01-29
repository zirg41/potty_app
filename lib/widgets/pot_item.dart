import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';

class PotItem extends StatelessWidget {
  final Pot pot;

  PotItem({@required this.pot});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              pot.name,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              pot.percent.toString(),
              style: TextStyle(fontSize: 18),
            ),
          ),
          const Expanded(child: SizedBox()),
          Container(
            //fit: FlexFit.tight,
            padding: const EdgeInsets.all(8),
            height: 50,
            width: 150,
            child: TextField(
              controller: TextEditingController(text: pot.amount.toString()),
            ),
          )
        ],
      ),
    );
  }
}
