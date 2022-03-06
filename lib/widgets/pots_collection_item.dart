import 'package:flutter/material.dart';
import 'package:potty_app/providers/pot_set.dart';
import 'package:potty_app/pages/pot_set_page.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class PotCollectionItem extends StatefulWidget {
  @override
  State<PotCollectionItem> createState() => _PotCollectionItemState();
}

class _PotCollectionItemState extends State<PotCollectionItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final PotSet potSetData = Provider.of<PotSet>(context);
    final themeData = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(PotSetPage.routeName, arguments: potSetData.id),
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text(
                potSetData.name,
                style: themeData.textTheme.bodyText1,
              ),
              subtitle: Text(
                potSetData.income.toString(),
                style: themeData.textTheme.subtitle1,
              ),
              trailing: IconButton(
                icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
              ),
            ),
            if (_expanded)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                height: min((potSetData.pots.length * 20.0 + 20), 180),
                child: ListView(
                  children: potSetData.pots
                      .map(
                        (pot) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              pot.name,
                              style: themeData.textTheme.subtitle1,
                            ),
                            Text(
                              pot.percent.toString(),
                              style: themeData.textTheme.subtitle1,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              )
          ],
        ),
      ),
    );
  }
}
