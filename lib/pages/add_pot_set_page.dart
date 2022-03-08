import 'package:flutter/material.dart';
import 'package:potty_app/widgets/custom_app_bar.dart';

class AddPotSetPage extends StatefulWidget {
  static const routeName = "/add-pot-set-page";
  AddPotSetPage();

  @override
  State<AddPotSetPage> createState() => _AddPotSetPageState();
}

class _AddPotSetPageState extends State<AddPotSetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Добавить",
        isBackButtonInit: true,
      ),
      body: Center(
        child: Text("Добавление нового potsets"),
      ),
    );
  }
}
