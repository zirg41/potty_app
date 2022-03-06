import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/providers/pot_set.dart';
import 'package:potty_app/pages/edit_pot_page.dart';
import 'package:potty_app/providers/pots.dart';
import 'package:potty_app/widgets/custom_app_bar.dart';
import 'package:potty_app/widgets/income_edit_show.dart';
import 'package:potty_app/widgets/pot_item.dart';
import 'package:potty_app/widgets/unallocated_pot.dart';
import 'package:provider/provider.dart';

class PotSetPage extends StatelessWidget {
  static const routeName = "/pot-set-page";
  @override
  Widget build(BuildContext context) {
    final String potSetDataId = ModalRoute.of(context).settings.arguments;
    final PotSet potSetData = Provider.of<PotsCollection>(context)
        .items
        .firstWhere((potSet) => potSet.id == potSetDataId);
    final List<Pot> pots = potSetData.pots;

    final themeData = Theme.of(context);
    final mq = MediaQuery.of(context);
    final _appbar = CustomAppBar(
      title: potSetData.name,
      isBackButtonInit: true,
    );
    var container = PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: UnallocatedPot(
        percent: potSetData.unallocatedPercent,
        amount: potSetData.unallocatedAmount,
      ),
    );

    const emptyWidg = SizedBox.shrink();
    return Scaffold(
      appBar: _appbar,
      body: Container(
        height: mq.size.height -
            mq.padding.bottom -
            mq.padding.top -
            _appbar.preferredSize.height,
        child: Column(
          children: [
            IncomeEditShow(potset: potSetData),
            potSetData.unallocatedAmount == 0.0 ? emptyWidg : container,
            Expanded(
              child: ListView.builder(
                itemCount: pots.length,
                itemBuilder: (context, index) =>
                    PotItem(potSetId: potSetData.id, pot: pots[index]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .pushNamed(EditPotPage.routeName, arguments: potSetData.id);
        },
        child: const Icon(Icons.add),
        backgroundColor: themeData.primaryColor,
      ),
    );
  }
}
