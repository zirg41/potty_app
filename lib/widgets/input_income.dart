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
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Введите доход, руб",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: incomeField,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.fromLTRB(10, 10, 35, 10),
            child: FlatButton(
              onPressed: calculate,
              color: Theme.of(context).primaryColor,
              child: const Text(
                "Вычислить",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
