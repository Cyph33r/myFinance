// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peronal_expenes_app/models/transaction.dart';
import 'package:peronal_expenes_app/widgets/new_transaction.dart';
import 'package:peronal_expenes_app/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(int) removeTransaction;

  const TransactionList(this.transactions, this.removeTransaction, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (_, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * .025,
                ),
                SizedBox(
                  height: constraints.maxHeight * .1,
                  child: Text(
                    "No Transactions added yet",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.025,
                ),
                SizedBox(
                    height: constraints.maxHeight * .85,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.contain,
                    ))
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return TransactionItem(
                  transaction: transactions[index],
                  removeTransaction: removeTransaction);
            });
  }
}
