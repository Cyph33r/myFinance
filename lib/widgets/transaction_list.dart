// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:peronal_expenes_app/models/transaction.dart';
import 'package:peronal_expenes_app/widgets/new_transaction.dart';

class TransactionList extends StatelessWidget {
  List<Transaction> transactions;

  TransactionList(this.transactions, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: [
              Text(
                "No Transactions added yet",
                style: Theme.of(context).textTheme.subtitle2,
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
                        child: FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                '\$${transactions[index].amount.toStringAsFixed(2)}'),
                          ),
                        ),
                      ),
                      title: Text(transactions[index].title),
                      subtitle: Text(
                        DateFormat.yMMMEd().format(transactions[index].date),
                      ),
                      trailing: IconButton(
                        splashColor: Theme.of(context).primaryColor,
                        focusColor: Theme.of(context).primaryColor,
                        hoverColor: Theme.of(context).primaryColor,
                        icon: Icon(Icons.delete,color: Colors.red,),
                        onPressed: () {},
                      ),
                    ),
                  );
                }),
          );
  }
}
