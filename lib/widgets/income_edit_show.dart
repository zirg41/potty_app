import 'package:flutter/material.dart';
import 'package:potty_app/config/themes/light_theme.dart';
import 'package:potty_app/providers/pot_set.dart';

class IncomeEditShow extends StatefulWidget {
  final PotSet potset;

  IncomeEditShow({this.potset});

  @override
  State<IncomeEditShow> createState() => _IncomeEditShowState();
}

class _IncomeEditShowState extends State<IncomeEditShow> {
  var _isChanging = false;
  final _form = GlobalKey<FormState>(debugLabel: "DL");
  final myController = TextEditingController();
  double adjustedIncome = 0.0;
  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final themeData = Theme.of(context);

    var inputDecoration = InputDecoration(
      suffix: Text("руб"),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      hintText: 'Введите доход',
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: CustomColors.mainColor,
          width: 2.0,
        ),
      ),
    );

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
            : Row(
                children: [
                  Container(
                    width: _mediaQuery.size.width * 3 / 5,
                    // height: 100,
                    child: TextField(
                      controller: myController,
                      decoration: inputDecoration,
                    ),
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
    );
  }
}
