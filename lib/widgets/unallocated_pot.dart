import 'package:flutter/material.dart';
import 'package:potty_app/config/themes/light_theme.dart';
import 'pot_item.dart' as potItem;

class UnallocatedPot extends StatelessWidget {
  final double percent;
  final double amount;
  UnallocatedPot({
    @required this.percent,
    @required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final ctxTheme = Theme.of(context);
    // return Container(
    //   height: 50,
    //   child: Column(
    //     children: [
    //       Text(percent.toString()),
    //       Text(amount.toString()),
    //     ],
    //   ),
    // );
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  // ПРОЦЕНТЫ
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: percent < 0.0
                          ? CustomColors.overallocatedColor
                          : CustomColors.unallocatedColor,
                      //border: Border.all(width: 8),
                      borderRadius: BorderRadius.circular(10)),
                  padding: potItem.PotItem.itemsPadding,
                  child: Text(
                    percent.toString(),
                    style:
                        const TextStyle(fontSize: 18, color: Color(0xFFf4f1de)),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      // СУММА
                      margin: const EdgeInsets.all(5),
                      //padding: itemsPadding,
                      child: Text(
                        amount.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    // НАИМЕНОВАНИЕ
                    //padding: itemsPadding,
                    margin: const EdgeInsets.only(
                        left: 5, right: 5, top: 0, bottom: 5),
                    child: FittedBox(
                      child: Text(
                        percent < 0.0 ? "Перераспределение" : "Не распределено",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
