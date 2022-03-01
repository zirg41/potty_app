import 'package:flutter/material.dart';
import 'package:potty_app/widgets/custom_app_bar.dart';

class PotDetailPage extends StatelessWidget {
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
