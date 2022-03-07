import 'package:flutter/material.dart';
import 'package:potty_app/providers/pot_set.dart';

class IncomeEditShow extends StatefulWidget {
  final PotSet potset;

  IncomeEditShow({this.potset});

  @override
  State<IncomeEditShow> createState() => _IncomeEditShowState();
}

class _IncomeEditShowState extends State<IncomeEditShow> {
  var _isChanging = false;
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Card(
      elevation: 8,
      margin: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
        width: double.infinity,
        child: !_isChanging
            ? Row(children: [
                Text(
                  "Ваш доход, руб: ",
                  style: themeData.textTheme.bodyText1,
                ),
                const Spacer(),
                Text(
                  widget.potset.income.toString(),
                  style: themeData.textTheme.headline2,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isChanging = !_isChanging;
                    });
                  },
                  child: const Text("Изменить"),
                ),
              ])
            : Form(
                key: _form,
                child: Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isChanging = !_isChanging;
                        });
                      },
                      child: const Text("Изменить"),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
