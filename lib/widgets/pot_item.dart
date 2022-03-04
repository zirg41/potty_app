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

    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  // ПРОЦЕНТЫ
                  margin: EdgeInsets.all(8),
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
                    style:
                        const TextStyle(fontSize: 18, color: Color(0xFFf4f1de)),
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
                      margin: EdgeInsets.all(5),
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
    );
  }
}
