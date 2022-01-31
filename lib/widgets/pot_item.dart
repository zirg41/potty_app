import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';

class PotItem extends StatelessWidget {
  final Pot pot;

  PotItem({@required this.pot});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: FittedBox(
                child: Text(
                  pot.name,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Container(
              // ОТОБРАЖЕНИЕ ПРОЦЕНТОВ
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  //border: Border.all(width: 8),
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(8),
              child: Text(
                "${pot.percent.toStringAsFixed(0)} %",
                style: Theme.of(context).textTheme.button,
              ),
            ),
            Container(
              // ОТОБРАЖЕНИЕ СУММЫ
              padding: const EdgeInsets.all(8),
              height: 50,
              width: 100,
              child: TextField(
                enabled: false,
                controller: TextEditingController(text: pot.amount.toString()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
