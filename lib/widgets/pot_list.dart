import 'package:flutter/material.dart';
import 'package:potty_app/models/pot.dart';
import 'package:potty_app/widgets/pot_item.dart';

class PotsList extends StatelessWidget {
  final List<Pot> pots;
  final Function deleteItemFunc;
  //final List<TextEditingController> controllers;

  PotsList({
    this.deleteItemFunc,
    @required this.pots,
  });

  @override
  Widget build(BuildContext context) {
    return pots.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                    width: 50,
                  ),
                  Container(
                    height: 300,
                    child: Image.asset(
                      "lib/assets/images/empty_state.jpg",
                      //fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            );
          })
        : ListView.builder(
            itemCount: pots.length,
            itemBuilder: (context, index) {
              return PotItem(
                pot: pots[index],
                deleteFunc: deleteItemFunc,
              );
            },
          );
  }
}
