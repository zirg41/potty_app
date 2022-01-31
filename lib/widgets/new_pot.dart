import 'package:flutter/material.dart';

class NewPot extends StatefulWidget {
  final Function addNewPot;

  NewPot({this.addNewPot});

  @override
  _NewPotState createState() => _NewPotState();
}

class _NewPotState extends State<NewPot> {
  final nameFieldController = TextEditingController();
  final percentFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        child: Container(
          //height: 500,
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 100),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                height: 50,
                child: const Text(
                  "Добавить категорию",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 25,
                  ),
                ),
              ),
              AddingNewPotField(
                hintText: "Введите наименование категории",
                itemController: nameFieldController,
              ),
              AddingNewPotField(
                hintText: "Введите проценты",
                itemController: percentFieldController,
                keyboardType: TextInputType.number,
                onSubmit: (_) => _submitData(),
              ),
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.topRight,
                child: OutlinedButton(
                    style: ButtonStyle(
                      side: MaterialStateProperty.all(
                        const BorderSide(width: 2, color: Colors.grey),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.only(
                            top: 15, bottom: 15, left: 20, right: 20),
                      ),
                    ),
                    onPressed: _submitData,
                    child: const Text(
                      "Добавить",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submitData() {
    if (nameFieldController.text.isEmpty || percentFieldController.text.isEmpty)
      return;

    final enteredName = nameFieldController.text;
    final enteredPercent = double.parse(percentFieldController.text);

    if (enteredPercent < 0) return;

    widget.addNewPot(
      enteredName,
      enteredPercent,
    );
    Navigator.of(context).pop();
  }
}

class AddingNewPotField extends StatelessWidget {
  final String hintText;
  final TextEditingController itemController;
  final TextInputType keyboardType;
  final Function onSubmit;
  AddingNewPotField(
      {@required this.hintText,
      @required this.itemController,
      this.keyboardType,
      this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: TextField(
        onSubmitted: onSubmit,
        keyboardType: keyboardType,
        controller: itemController,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: "Montserrat",
              fontSize: 16,
            ),
            border: const OutlineInputBorder()),
      ),
    );
  }
}
