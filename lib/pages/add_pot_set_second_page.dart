import 'package:flutter/material.dart';
import 'package:potty_app/config/themes/light_theme.dart';
import 'package:potty_app/pages/edit_pot_page.dart';
import 'package:potty_app/pages/pot_set_page.dart';
import 'package:potty_app/providers/pots.dart';
import 'package:potty_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class AddPotSetSecondPage extends StatefulWidget {
  static const routeName = "/add-pot-set-second-page";

  @override
  State<AddPotSetSecondPage> createState() => _AddPotSetSecondPageState();
}

class _AddPotSetSecondPageState extends State<AddPotSetSecondPage> {
  final _textController = TextEditingController();

  final inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(10),
    fillColor: CustomColors.backgroundColor,
    filled: true,
    suffix: const Text("руб"),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    hintText: 'Доход, руб',
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
    var nameOfPotSet = ModalRoute.of(context).settings.arguments;
    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: nameOfPotSet,
        isBackButtonInit: true,
      ),
      body: Container(
        alignment: Alignment.center,
        height: _mediaQuery.size.height * 0.4,
        width: _mediaQuery.size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Введите величину дохода",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                autofocus: true,
                controller: _textController,
                decoration: inputDecoration,
                onEditingComplete: () => _submitData(context, nameOfPotSet),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerRight,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: CustomColors.mainColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                onPressed: () => _submitData(context, nameOfPotSet),
                child: const SizedBox(
                  height: 50,
                  width: 140,
                  child: Center(
                      child: Text(
                    "Далее",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitData(BuildContext context, Object nameOfPotSet) {
    String potSetId = Provider.of<PotsCollection>(context, listen: false)
        .createPotSet(nameOfPotSet, double.parse(_textController.text));

    Navigator.of(context)
        .pushReplacementNamed(PotSetPage.routeName, arguments: potSetId);
  }
}
