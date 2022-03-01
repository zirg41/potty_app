import 'package:flutter/material.dart';
import 'package:potty_app/models/pot_set.dart';
import 'package:potty_app/providers/pots.dart';
import 'package:potty_app/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class PotSetPage extends StatelessWidget {
  static const routeName = "/pot-set-page";
  @override
  Widget build(BuildContext context) {
    final PotSet potSetData =
        ModalRoute.of(context).settings.arguments as PotSet;
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: potSetData.name,
      ),
      body: Container(),
    );
  }
}
