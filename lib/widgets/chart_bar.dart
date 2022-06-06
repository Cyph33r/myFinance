import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double pctOfTotalSpent;

  ChartBar(this.label, this.spending, this.pctOfTotalSpent, {Key? key})
      : super(key: key) {
    print(pctOfTotalSpent);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(spending.toStringAsFixed(2)),
        Stack(
          children: [
            Container(
              height: 100,
              width: 10,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: const Color.fromARGB(255, 217, 217, 217),
                  borderRadius: BorderRadius.circular(10)),
              child: FractionallySizedBox(
                heightFactor: pctOfTotalSpent,
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(label)
      ],
    );
  }
}
