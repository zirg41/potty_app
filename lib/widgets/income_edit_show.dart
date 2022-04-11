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
  final myController = TextEditingController();

  double adjustedIncome = 0.0;

  final inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(10),
    suffix: Text("руб"),
    fillColor: CustomColors.backgroundColor,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    // hintText: 'Введите доход',
    focusedBorder: null,
    enabledBorder: null,
  );

  @override
  void didChangeDependencies() {
    myController.text = widget.potset.income.toString();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final themeData = Theme.of(context);

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Ваш доход: ",
                  style: themeData.textTheme.bodyText1,
                ),
                const Spacer(flex: 1),
                SizedBox(
                  width: _mediaQuery.size.width * 2 / 5,
                  child: TextField(
                    style: themeData.textTheme.headline2,
                    controller: myController,
                    decoration: inputDecoration,
                  ),
                ),
                const Spacer(
                  flex: 3,
                ),
                TextButton(
                  onPressed: submitNewIncome,
                  child: const Text("Сохранить"),
                ),
              ],
            ),
          ],
        ));
  }

  void submitNewIncome() {
    FocusManager.instance.primaryFocus?.unfocus();
    adjustedIncome = double.tryParse(myController.text);

    if (adjustedIncome == null) {
      Scaffold.of(context).showSnackBar(
        const SnackBar(
          content: Text("Введите корректную величину!"),
        ),
      );
      myController.text = widget.potset.income.toString();
      return;
    }

    // myController.text = ""; // clearing field
    Provider.of<PotsCollection>(context, listen: false)
        .changeIncome(widget.potset.id, adjustedIncome);
  }
}
