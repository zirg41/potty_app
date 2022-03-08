import 'package:flutter/material.dart';
import 'package:potty_app/config/themes/light_theme.dart';
import 'package:potty_app/widgets/custom_app_bar.dart';

class AddPotSetFirstPage extends StatefulWidget {
  static const routeName = "/add-pot-set-page";
  AddPotSetFirstPage();

  @override
  State<AddPotSetFirstPage> createState() => _AddPotSetFirstPageState();
}

class _AddPotSetFirstPageState extends State<AddPotSetFirstPage> {
  final _textController = TextEditingController();
  final inputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(10),
    fillColor: CustomColors.backgroundColor,
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    hintText: 'Например, "Зарплата" или "Аванс"',
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

    return Scaffold(
      appBar: CustomAppBar(
        title: "Добавить",
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
                "Введите наименование",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _textController,
                decoration: inputDecoration,
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
                onPressed: () => {},
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
}
