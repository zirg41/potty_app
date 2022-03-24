import 'package:flutter/material.dart';
import 'package:potty_app/providers/pot_set.dart';
import 'package:potty_app/pages/pot_set_page.dart';
import 'package:potty_app/providers/pots.dart';
import 'package:provider/provider.dart';

class PotCollectionItem extends StatefulWidget {
  @override
  State<PotCollectionItem> createState() => _PotCollectionItemState();
}

class _PotCollectionItemState extends State<PotCollectionItem> {
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
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  final bool response = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Вы уверены?"),
                      content: const Text("Удалить данную позицию?"),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text("Нет"),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text(
                            "Да",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                  if (response) {
                    Provider.of<PotsCollection>(context, listen: false)
                        .deletePotSetFromMemory(potSetData.id);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
