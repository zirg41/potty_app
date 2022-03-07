import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/providers/pots.dart';
import 'package:potty_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class EditPotPage extends StatefulWidget {
  static const routeName = "/edit-pot-page";

  @override
  State<EditPotPage> createState() => _EditPotPageState();
}

class _EditPotPageState extends State<EditPotPage> {
  final _form = GlobalKey<FormState>();

  Map<String, Object> _initValues = {
    'name': "",
    'percent': null,
    "amount": null,
  };

  Pot _editedPot = Pot(
    id: null,
    name: "",
    percent: null,
    amount: null,
  );

  void _saveForm(String potSetId) {
    FocusManager.instance.primaryFocus?.unfocus(); // closing keyboard
    bool isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }
    _form.currentState.save();
    _editedPot = Pot(
      // assigning id
      id: DateTime.now().toString(),
      name: _editedPot.name,
      percent: _editedPot.percent,
      amount: _editedPot.amount,
    );
    // TODO
    // checking if user entered amount value or not
    // if so here needs to calculate percent based on input amount
    // else return
    if (currentDropdownValue == dropdownValues[0]) {
      Provider.of<PotsCollection>(context, listen: false)
          .addPot(potSetId, _editedPot);
      Provider.of<PotsCollection>(context, listen: false).calculate(potSetId);
      Navigator.of(context).pop();
    }
    if (currentDropdownValue == dropdownValues[1]) {
      final _calculatedPot = Provider.of<PotsCollection>(context, listen: false)
          .calculatePercentBasedOnAmount(potSetId, _editedPot);
      Provider.of<PotsCollection>(context, listen: false)
          .addPot(potSetId, _calculatedPot);
      Provider.of<PotsCollection>(context, listen: false).calculate(potSetId);
      Navigator.of(context).pop();
    }

    // print(
    //   "Наименование: ${_editedPot.name}," +
    //       " Проценты: ${_editedPot.percent}," +
    //       " Сумма: ${_editedPot.amount}",
    // );

    // Provider.of<PotsCollection>(context, listen: false).calculate(potSetId);
    // Navigator.of(context).pop();
  }

  List<String> dropdownValues = ['Проценты', 'Сумма'];
  String currentDropdownValue = 'Проценты';

  @override
  Widget build(BuildContext context) {
    final String potSetId = ModalRoute.of(context).settings.arguments as String;

    // print(income);
    final _mediaQuery = MediaQuery.of(context);
    final themeData = Theme.of(context);

    final _enabledBorder = OutlineInputBorder(
      borderSide: const BorderSide(
          width: 1.5, color: Color.fromARGB(255, 122, 122, 122)),
      borderRadius: BorderRadius.circular(10),
    );

    final _focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1.5, color: themeData.primaryColor),
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
          padding: const EdgeInsets.all(10),
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
                  return "Введите наименование";
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
                  padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5),
                  child: TextFormField(
                    initialValue: currentDropdownValue == dropdownValues[0]
                        ? _initValues['percent']
                        : _initValues['amount'],
                    decoration: InputDecoration(
                      labelText: currentDropdownValue,
                      enabledBorder: _enabledBorder,
                      focusedBorder: _focusedBorder,
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    onSaved: (newValue) {
                      _editedPot = Pot(
                        id: _editedPot.id,
                        name: _editedPot.name,
                        amount: currentDropdownValue == dropdownValues[1]
                            ? double.parse(newValue)
                            : _editedPot.amount,
                        percent: currentDropdownValue == dropdownValues[0]
                            ? double.parse(newValue)
                            : _editedPot.percent,
                      );
                    },
                  ),
                ),
                Container(
                  width: (_mediaQuery.size.width - 20) * 1 / 3,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.5,
                        color: const Color.fromARGB(255, 122, 122, 122)),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    value: currentDropdownValue,
                    icon: const Icon(Icons.arrow_drop_down_outlined),
                    style:
                        TextStyle(color: themeData.primaryColor, fontSize: 15),
                    underline: const SizedBox.shrink(),
                    isExpanded: true,
                    onChanged: (String newValue) {
                      if (newValue == null) {
                        return;
                      }
                      setState(() {
                        currentDropdownValue = newValue;
                        if (newValue == dropdownValues[0]) {
                          _editedPot.amount = null;
                        }
                        if (newValue == dropdownValues[1]) {
                          _editedPot.percent = null;
                        }
                      });
                    },
                    items: dropdownValues
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
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: themeData.primaryColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  onPressed: () => _saveForm(potSetId),
                  child: const SizedBox(
                    height: 50,
                    width: 150,
                    child: Center(
                        child: Text(
                      "Сохранить",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
