// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  var titleController = TextEditingController();
  var amountController = TextEditingController();
  final transactions = [
    Transaction(
        id: 01, title: "New Shoes", amount: 10000.0, time: DateTime.now()),
    Transaction(
        id: 02, title: "Weekly Grocery", amount: 4000.0, time: DateTime.now()),
  ];
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: const Card(
              color: Colors.blue,
              child: Text('CHART!'),
              elevation: 5,
            ),
          ),
          Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      labelText: "Title",
                    ),
                    controller: titleController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Amount"),
                    controller: amountController,
                  ),
                  FlatButton(
                    onPressed: () {
                      print(titleController.text);
                      print(amountController.text);
                    },
                    child: Text(
                      "Add Transaction",
                      style: TextStyle(color: Colors.purple),
                    ),
                  )
                ],
              ),
            ),
          ),
          Column(
            children: transactions.map((transaction) {
              return Card(
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.purple,
                                width: 2,
                                style: BorderStyle.solid)),
                        child: Text('₦${transaction.amount}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.purple,
                            )),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transaction.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            Text(
                              DateFormat.yMMMMd().format(transaction.time),
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
