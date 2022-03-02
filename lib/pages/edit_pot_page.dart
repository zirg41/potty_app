import 'package:flutter/material.dart';
import 'package:potty_app/widgets/custom_app_bar.dart';

class EditPotPage extends StatefulWidget {
  static const routeName = "/edit-pot-page";

  EditPotPage();

  @override
  State<EditPotPage> createState() => _EditPotPageState();
}

class _EditPotPageState extends State<EditPotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "Редактировать категорию", isBackButtonInit: true),
    );
  }
}
