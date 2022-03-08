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
      contentPadding: EdgeInsets.all(10),
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
      width: double.infinity,
      child: !_isChanging
          ? Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Ваш доход: ",
                      style: themeData.textTheme.bodyText1,
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "${widget.potset.income.toString()} руб.",
                        style: themeData.textTheme.headline2,
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
              ],
            )
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
                  child: const Text("Сохранить"),
                ),
              ],
            ),
    );
  }
}
