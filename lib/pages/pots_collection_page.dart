import 'package:flutter/material.dart';
import 'package:potty_app/models/pot_set.dart';
import 'package:potty_app/providers/pots.dart';
import 'package:potty_app/widgets/custom_app_bar.dart';
import 'package:potty_app/widgets/pots_collection_item.dart';
import 'package:provider/provider.dart';

class PotsCollectionPage extends StatelessWidget {
  static const routeName = "/pots-collection-page";
  const PotsCollectionPage();

  @override
  Widget build(BuildContext context) {
    final List<PotSet> potsCollect =
        Provider.of<PotsCollection>(context, listen: false).items;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Your pots",
      ),
      body: Container(
        height: 635,
        width: double.infinity,
        child: ListView.builder(
          itemCount: potsCollect.length,
          itemBuilder: (context, index) => ChangeNotifierProvider(
            create: (context) => potsCollect[index],
            child: PotCollectionItem(),
          ),
        ),
      ),
    );
  }
}
