import 'package:flutter/material.dart';
import 'package:potty_app/providers/pot_set.dart';

class IncomeEditShow extends StatefulWidget {
  final PotSet potset;

  IncomeEditShow({this.potset});

  @override
  State<IncomeEditShow> createState() => _IncomeEditShowState();
}

class _IncomeEditShowState extends State<IncomeEditShow> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        width: double.infinity,
        child: Row(children: [
          Text(
            "Ваш доход, руб: ",
            style: themeData.textTheme.bodyText1,
          ),
          Spacer(),
          Text(
            "${widget.potset.income.toString()}",
            style: themeData.textTheme.headline2,
          ),
        ]),
      ),
    );
  }
}
