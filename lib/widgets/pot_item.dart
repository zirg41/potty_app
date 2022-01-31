import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potty_app/models/pot.dart';

class PotItem extends StatelessWidget {
  final Pot pot;

  // ignore: use_key_in_widget_constructors
  const PotItem({@required this.pot});

  @override
  Widget build(BuildContext context) {
    const itemsPadding = EdgeInsets.all(8);
    final ctxTheme = Theme.of(context);

    const snackBar = SnackBar(
      content: Text('Скопировано!'),
      duration: Duration(seconds: 1),
    );

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
                  onTap: () {
                    Clipboard.setData(
                        ClipboardData(text: pot.amount.toString()));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Container(
                    width: 100,
                    // ОТОБРАЖЕНИЕ СУММЫ
                    decoration: BoxDecoration(
                        color: ctxTheme.accentColor,
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
