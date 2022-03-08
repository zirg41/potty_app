import 'package:flutter/material.dart';
import 'package:potty_app/config/themes/light_theme.dart';
import 'package:potty_app/providers/pot_set.dart';
import 'package:potty_app/providers/pots.dart';
import 'package:provider/provider.dart';

class IncomeEditShow extends StatefulWidget {
  final PotSet potset;

  IncomeEditShow({this.potset});

  @override
  State<IncomeEditShow> createState() => _IncomeEditShowState();
}

class _IncomeEditShowState extends State<IncomeEditShow> {
  var _isChanging = false;
  final myController = TextEditingController();

  double adjustedIncome = 0.0;

  final inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(10),
    suffix: const Text("руб"),
    fillColor: CustomColors.backgroundColor,
    filled: true,
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

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final themeData = Theme.of(context);

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
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 50,
                          width: _mediaQuery.size.width / 3.5,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: CustomColors.backgroundColor,
                            border: Border.all(
                              color: CustomColors.hintColor,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            widget.potset.income.toString(),
                            style: themeData.textTheme.headline2,
                          ),
                        ),
                        Container(
                          height: 50,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: CustomColors.hintColor,
                            border: Border.all(
                              color: CustomColors.hintColor,
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Text(
                            "руб",
                            style: themeData.textTheme.headline3,
                          ),
                        ),
                      ],
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
                SizedBox(
                  width: _mediaQuery.size.width * 3 / 5,
                  height: 50,
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
                    adjustedIncome = double.parse(myController.text);
                    myController.text = ""; // clearing field
                    Provider.of<PotsCollection>(context, listen: false)
                        .changeIncome(widget.potset.id, adjustedIncome);
                    ;
                  },
                  child: const Text("Сохранить"),
                ),
              ],
            ),
    );
  }
}
