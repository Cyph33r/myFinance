import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.removeTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function(int transactionId) removeTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
        ),
        title: Text(transaction.title),
        subtitle: Text(
          DateFormat.yMMMEd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width < 360
            ? IconButton(
                color: Theme.of(context).errorColor,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => removeTransaction(transaction.id),
              )
            : TextButton.icon(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () => removeTransaction(transaction.id),
                label: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                )),
      ),
    );
  }
}
