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
  double adjustedIncome = 0.0;
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
            : Container(
                child: Form(
                  key: _form,
                  child: Row(
                    children: [
                      TextFormField(
                        initialValue: "Введите доход",
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Введите сумму";
                          }
                          if (double.tryParse(value) == null) {
                            return "Please enter a valid number";
                          }
                          if (double.parse(value) <= 0) {
                            return "Please enter a valid number";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          adjustedIncome = double.parse(newValue);
                        },
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
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
