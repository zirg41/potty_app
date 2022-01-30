import 'package:flutter/material.dart';

class NewPot extends StatefulWidget {
  final Function addNewPot;

  NewPot({this.addNewPot});

  @override
  _NewPotState createState() => _NewPotState();
}

class _NewPotState extends State<NewPot> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(height: 500),
      ),
    );
  }
}
