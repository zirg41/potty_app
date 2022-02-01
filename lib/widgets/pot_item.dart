import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:potty_app/models/pot.dart';

class PotItem extends StatelessWidget {
  final Pot pot;
  final Function deleteFunc;
  // ignore: use_key_in_widget_constructors
  const PotItem({
    this.deleteFunc,
    @required this.pot,
  });

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
              Container(
                // ПРОЦЕНТЫ
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    //border: Border.all(width: 8),
                    borderRadius: BorderRadius.circular(10)),
                padding: itemsPadding,
                child: Text(
                  "${pot.percent.toStringAsFixed(0)} %",
                  style:
                      const TextStyle(fontSize: 21, color: Color(0xFFf4f1de)),
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
                        style: const TextStyle(fontSize: 21),
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
          Container(
            margin: itemsPadding,
            child: IconButton(
              onPressed: () => deleteFunc(pot.id),
              icon: const Icon(Icons.delete),
              color: ctxTheme.errorColor,
            ),
          )
        ],
      ),
    );
  }
}
