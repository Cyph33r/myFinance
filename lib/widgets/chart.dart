import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  const Chart(this.recentTransaction, {Key? key}) : super(key: key);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalAmount = 0.0;
      for (var transaction in recentTransaction) {
        if (transaction.date.day == weekDay.day &&
            transaction.date.month == weekDay.month &&
            transaction.date.year == weekDay.year) {
          totalAmount += transaction.amount;
        }
      }
      return {
        'day': DateFormat('E').format(weekDay)[0],
        'amount': totalAmount
      };
    }).reversed.toList();

  }

  double get totalSpending {
    return groupedTransactions.fold(
        0.0,
        (previousValue, transaction) =>
            previousValue + (transaction['amount'] as double));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactions
                .map((day) => Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                          day['day'] as String,
                          day['amount'] as double,
                          (day['amount'] as double) / totalSpending),
                    ))
                .toList()),
      ),
      elevation: 6,
    );
  }
}
