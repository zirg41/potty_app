import 'package:flutter/material.dart';
import 'package:potty_app/providers/pots.dart';
import 'package:potty_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class PotSetPage extends StatelessWidget {
  static const routeName = "/pot-set-page";
  @override
  Widget build(BuildContext context) {
    final potsData = Provider.of<PotsCollection>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Your pots",
      ),
      body: Container(),
    );
  }
}
