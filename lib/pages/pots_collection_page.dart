import 'package:flutter/material.dart';
import 'package:potty_app/widgets/custom_app_bar.dart';

class PotsCollectionPage extends StatelessWidget {
  static const routeName = "/pots-collection-page";
  const PotsCollectionPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Your pots",
      ),
      body: Container(),
    );
  }
}
