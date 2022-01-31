import 'package:flutter/material.dart';

class InputIncomeField extends StatelessWidget {
  final TextEditingController incomeField;
  final Function calculate;

  InputIncomeField({
    @required this.incomeField,
    @required this.calculate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (_) => calculate,
              keyboardType: TextInputType.number,
              controller: incomeField,
              decoration: const InputDecoration(
                hintText: "Введите доход, руб",
                hintStyle: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 16,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 8, right: 8),
            child: OutlinedButton(
              onPressed: calculate,
              style: ButtonStyle(
                // side: MaterialStateProperty.all(
                //   const BorderSide(width: 1, color: Colors.grey),
                // ),
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).accentColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.only(
                      top: 15, bottom: 15, left: 20, right: 20),
                ),
              ),
              child: Text(
                "Вычислить",
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
