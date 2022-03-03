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
    'percent': null,
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
    print(
        "Наименование: ${_editedPot.name}, Проценты: ${_editedPot.percent}, Сумма: ${_editedPot.amount}");
  }

  String dropdownValue = 'Проценты';
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
        child: Container(
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
                    width: (_mediaQuery.size.width - 20) * 2 / 3,
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, right: 5),
                    child: TextFormField(
                      initialValue: _initValues['percent'],
                      decoration: InputDecoration(
                        labelText: dropdownValue,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 1.5,
                              color: Color.fromARGB(255, 122, 122, 122)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 1.5,
                              color: Theme.of(context).primaryColor),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (newValue) {
                        _editedPot = Pot(
                          id: _editedPot.id,
                          name: _editedPot.name,
                          amount: dropdownValue == "Сумма"
                              ? double.parse(newValue)
                              : _editedPot.amount,
                          percent: dropdownValue == "Проценты"
                              ? double.parse(newValue)
                              : _editedPot.percent,
                        );
                      },
                    ),
                  ),
                  Container(
                    width: (_mediaQuery.size.width - 20) * 1 / 3,
                    padding: const EdgeInsets.only(top: 4, bottom: 4, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1.5,
                          color: Color.fromARGB(255, 122, 122, 122)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down_outlined),
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 17),
                      underline: const SizedBox.shrink(),
                      onChanged: (String newValue) {
                        if (newValue == null) {
                          return;
                        }
                        setState(() {
                          dropdownValue = newValue;
                        });
                      },
                      items: <String>['Проценты', 'Сумма']
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: _saveForm,
                    child: const Text("Сохранить"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
