import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';

class PotItem extends StatelessWidget {
  Pot pot;

  PotItem({@required this.pot});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(pot.name),
        Flexible(
          fit: FlexFit.tight,
          child: TextField(
            controller: TextEditingController(),
          ),
        )
      ],
    );
  }
}
