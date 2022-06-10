import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double pctOfTotalSpent;

  ChartBar(this.label, this.spending, this.pctOfTotalSpent, {Key? key})
      : super(key: key) {}

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text(
              '₦${spending.toStringAsFixed(0)}',
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Stack(
          children: [
            Container(
              height: 70,
              width: 14,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2.0),
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
        const SizedBox(
          height: 3,
        ),
        Text(label)
      ],
    );
  }
}
