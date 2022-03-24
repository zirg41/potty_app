import 'package:flutter/material.dart';
import 'package:potty_app/pages/add_pot_set_first_page.dart';
import 'package:potty_app/providers/pot_set.dart';
import 'package:potty_app/providers/pots.dart';
import 'package:potty_app/widgets/pots_collection_item.dart';
import 'package:provider/provider.dart';

class PotsCollectionPage extends StatelessWidget {
  static const routeName = "/pots-collection-page";
  const PotsCollectionPage();

  @override
  Widget build(BuildContext context) {
    final List<PotSet> potsCollect = Provider.of<PotsCollection>(context).items;
    return Scaffold(
      appBar: AppBar(
        leading: null,

        title: Text(
          "Your pots",
          style: Theme.of(context).textTheme.headline1,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // foregroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      body: SizedBox(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddPotSetFirstPage.routeName);
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
