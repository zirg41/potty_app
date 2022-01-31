import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potty_app/models/pot.dart';

class PotItem extends StatelessWidget {
  final Pot pot;

  PotItem({@required this.pot});

  @override
  Widget build(BuildContext context) {
    const itemsPadding = EdgeInsets.all(8);
    final ctxTheme = Theme.of(context);

    return Card(
      child: SizedBox(
        height: 55,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: itemsPadding,
              child: FittedBox(
                child: Text(
                  pot.name,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            //const Expanded(child: SizedBox()),
            Row(
              children: [
                Container(
                  // ОТОБРАЖЕНИЕ ПРОЦЕНТОВ
                  decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      //border: Border.all(width: 8),
                      borderRadius: BorderRadius.circular(10)),
                  padding: itemsPadding,
                  child: Text(
                    "${pot.percent.toStringAsFixed(0)} %",
                    style: ctxTheme.textTheme.button,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 100,
                    // ОТОБРАЖЕНИЕ СУММЫ
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10)),
                    padding: itemsPadding,
                    child: Text(
                      pot.amount.toString(),
                      style: ctxTheme.textTheme.button,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
