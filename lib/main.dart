// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:peronal_expenes_app/widgets/chart.dart';
import 'package:peronal_expenes_app/widgets/new_transaction.dart';
import 'package:peronal_expenes_app/widgets/transaction_list.dart';
import 'models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.purple, accentColor: Colors.amber)
            .copyWith(secondary: Colors.amber),
        fontFamily: 'Droid Sans',
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.dark()
              .textTheme
              .subtitle1
              ?.copyWith(fontSize: 20, fontFamily: 'OpenSans'),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.normal),
              button: TextStyle(color: Colors.white),
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static int lastIndex = 0;
  final List<Transaction> userTransactions = [
    Transaction(
      id: lastIndex++,
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime(2022, 6, 5),
    ),
    Transaction(
      id: lastIndex++,
      title: 'New House',
      amount: 40.24,
      date: DateTime(2022, 6, 7),
    ),
    Transaction(
      id: lastIndex++,
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get recentTransactions => userTransactions
      .where((transaction) =>
          transaction.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
      .toList();

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime transactionDate) {
    Transaction newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: transactionDate,
      id: lastIndex++,
    );
    setState(() => userTransactions.add(newTx));
  }

  void _deleteTransaction(int id) {
    setState(() =>
        userTransactions.removeWhere((transaction) => transaction.id == id));
  }

  void startNewTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: NewTransaction(_addNewTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Flutter App'),
        actions: [
          IconButton(
              onPressed: () {
                startNewTransaction(context);
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(recentTransactions),
            TransactionList(userTransactions,_deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startNewTransaction(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
