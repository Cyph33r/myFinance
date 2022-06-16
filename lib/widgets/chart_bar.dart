import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double pctOfTotalSpent;

  const ChartBar(this.label, this.spending, this.pctOfTotalSpent, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: constraints.maxHeight * .17,
            child: FittedBox(
              child: Text(
                '\$${spending.toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ),
          // const SizedBox(
          //   height: 2,
          // ),
          Stack(
            children: [
              Container(
                height: constraints.maxHeight * .6,
                width: 14,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2.0),
                    color: const Color.fromARGB(255, 217, 217, 217),
                    borderRadius: BorderRadius.circular(10)),
                child: FractionallySizedBox(
                  heightFactor: pctOfTotalSpent.isNaN ? 0 : pctOfTotalSpent,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient:  LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context).colorScheme.secondary,
                          ]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: constraints.maxHeight * .1,
          ),
          SizedBox(
            height: constraints.maxHeight * .13,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                label,
              ),
            ),
          ),
        ],
      );
    });
  }
}
