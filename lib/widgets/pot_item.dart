import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potty_app/pages/edit_pot_page.dart';
import 'package:potty_app/providers/pot_set.dart';
import 'package:potty_app/providers/pots.dart';
import 'package:provider/provider.dart';

import '/models/pot.dart';

class PotItem extends StatelessWidget {
  final String potSetId;
  final Pot pot;
  PotItem({
    @required this.potSetId,
    @required this.pot,
  });
  static const itemsPadding = EdgeInsets.all(10);
  @override
  Widget build(BuildContext context) {
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
        if (direction == DismissDirection.startToEnd) {
          Navigator.of(context).pushNamed(EditPotPage.routeName,
              arguments: {"pot-set-id": potSetId, "pot-id": pot.id});
        }
        return null;
      },
      onDismissed: (direction) {
        Provider.of<PotsCollection>(context, listen: false)
            .deletePot(potSetId, pot.id);
        Provider.of<PotsCollection>(context, listen: false).calculate(potSetId);
      },
      child: Card(
        elevation: 5,
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
                          : "${pot.percent.toStringAsFixed(pot.percent.truncateToDouble() == pot.percent ? 0 : 1)} %",
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
                          pot.amount != null
                              ? pot.amount.toStringAsFixed(
                                  pot.amount.truncateToDouble() == pot.amount
                                      ? 0
                                      : 2)
                              : "-",
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
