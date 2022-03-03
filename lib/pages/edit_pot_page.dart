import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/widgets/custom_app_bar.dart';

class EditPotPage extends StatefulWidget {
  static const routeName = "/edit-pot-page";

  EditPotPage();

  @override
  State<EditPotPage> createState() => _EditPotPageState();
}

class _EditPotPageState extends State<EditPotPage> {
  final _form = GlobalKey<FormState>();

  var _initValues = {
    'name': "",
    'percent': "",
    "amount": "",
  };

  Pot _editedPot = Pot(
    id: null,
    name: "",
    percent: null,
    amount: null,
  );
  Future<void> _saveForm() async {
    bool isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }
    _form.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);

    final _enabledBorder = OutlineInputBorder(
      borderSide: const BorderSide(
          width: 1.5, color: Color.fromARGB(255, 122, 122, 122)),
      borderRadius: BorderRadius.circular(10),
    );
    final _focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: Theme.of(context).primaryColor),
      borderRadius: BorderRadius.circular(10),
    );
    return Scaffold(
      appBar: CustomAppBar(
        title: "Редактировать категорию",
        isBackButtonInit: true,
      ),
      body: Form(
        key: _form,
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            TextFormField(
              initialValue: _initValues['name'],
              decoration: InputDecoration(
                labelText: "Наименование",
                enabledBorder: _enabledBorder,
                focusedBorder: _focusedBorder,
              ),
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value.isEmpty) {
                  return "Приведите название";
                }
                return null;
              },
              onSaved: (newValue) {
                _editedPot = Pot(
                  id: _editedPot.id,
                  name: newValue,
                  amount: _editedPot.amount,
                  percent: _editedPot.percent,
                );
              },
            ),
            Row(
              children: [
                Container(
                  width: (_mediaQuery.size.width - 20) / 2,
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5),
                  child: TextFormField(
                    initialValue: _initValues['percent'],
                    decoration: InputDecoration(
                      labelText: "Проценты",
                      enabledBorder: _enabledBorder,
                      focusedBorder: _focusedBorder,
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Приведите проценты";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editedPot = Pot(
                        id: _editedPot.id,
                        name: _editedPot.name,
                        amount: _editedPot.amount,
                        percent: double.parse(newValue),
                      );
                    },
                  ),
                ),
                Container(
                  width: (_mediaQuery.size.width - 20) / 2,
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 5),
                  child: TextFormField(
                    initialValue: _initValues['amount'],
                    decoration: InputDecoration(
                      labelText: "Сумма",
                      enabledBorder: _enabledBorder,
                      focusedBorder: _focusedBorder,
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Приведите сумму";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _editedPot = Pot(
                        id: _editedPot.id,
                        name: _editedPot.name,
                        amount: double.parse(newValue),
                        percent: _editedPot.percent,
                      );
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: (() {}),
                  child: const Text("Сохранить"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
