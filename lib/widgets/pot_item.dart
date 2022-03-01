import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';

class PotItem extends StatelessWidget {
  final Pot pot;
  const PotItem(this.pot);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Text(pot.name),
    );
  }
}
