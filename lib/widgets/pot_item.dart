import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/models/pot.dart';

class PotItem extends StatelessWidget {
  final Pot pot;
  const PotItem(this.pot);

  @override
  Widget build(BuildContext context) {
    const itemsPadding = EdgeInsets.all(10);
    final ctxTheme = Theme.of(context);
    const snackBar = SnackBar(
      content: Text('Скопировано!'),
      duration: Duration(seconds: 1),
    );

    return Dismissible(
      key: ValueKey(pot.id),
      background: Container(
        color: Colors.orange,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(Icons.settings),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        child: const Icon(Icons.delete),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
      ),
      confirmDismiss: (direction) {
        if (direction == DismissDirection.endToStart) {
          return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Вы уверены?"),
              content: const Text("Удалить данную позицию?"),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text("Нет"),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(
                    "Да",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
          );
        }
        return null;
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    // ПРОЦЕНТЫ
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: (pot.name != "Не распределено") &&
                                (pot.name != "Перераспределение")
                            ? ctxTheme.primaryColor
                            : pot.name == "Перераспределение"
                                ? ctxTheme.errorColor
                                : ctxTheme.focusColor,
                        //border: Border.all(width: 8),
                        borderRadius: BorderRadius.circular(10)),
                    padding: itemsPadding,
                    child: Text(
                      pot.percent == null
                          ? ""
                          : "${pot.percent.toStringAsFixed(0)} %",
                      style: const TextStyle(
                          fontSize: 18, color: Color(0xFFf4f1de)),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                            ClipboardData(text: pot.amount.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Container(
                        // СУММА
                        margin: const EdgeInsets.all(5),
                        //padding: itemsPadding,
                        child: Text(
                          pot.amount != null ? pot.amount.toString() : "-",
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    Container(
                      // НАИМЕНОВАНИЕ
                      //padding: itemsPadding,
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, top: 0, bottom: 5),
                      child: FittedBox(
                        child: Text(
                          pot.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
