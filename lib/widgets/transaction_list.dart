// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peronal_expenes_app/models/transaction.dart';
import 'package:peronal_expenes_app/widgets/new_transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function(int) removeTransaction;

  TransactionList(this.transactions, this.removeTransaction, {Key? key})
      : super(key: key){
    print(transactions);
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                "No Transactions added yet",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 300,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.contain,
                  ))
            ],
          )
        : Container(
            height: 400,
            child: ListView.builder(
                itemCount: transactions.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '\$${transactions[index].amount.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                        ),
                      ),
                      title: Text(transactions[index].title),
                      subtitle: Text(
                        DateFormat.yMMMEd().format(transactions[index].date),
                      ),
                      trailing: IconButton(
                        color: Theme.of(context).errorColor,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () =>
                            removeTransaction(transactions[index].id),
                      ),
                    ),
                  );
                }),
          );
  }
}
