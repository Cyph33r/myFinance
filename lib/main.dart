import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:peronal_expenes_app/widgets/chart.dart';
import 'package:peronal_expenes_app/widgets/new_transaction.dart';
import 'package:peronal_expenes_app/widgets/transaction_list.dart';
import 'models/transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]).then((_) {
    runApp(const MyApp());
  });
}

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
              subtitle1: const TextStyle(
                  fontSize: 18,
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.normal),
              button: const TextStyle(color: Colors.white),
            ),
      ),
      home: const MyHomePage(),
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
  bool showChart = true;
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
    Transaction(
      id: lastIndex++,
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: lastIndex++,
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get recentTransactions => userTransactions
      .where((transaction) => transaction.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7))))
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
        isScrollControlled: true,
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
    var mediaQueryData = MediaQuery.of(context);
    final bool isInLandscape =
        mediaQueryData.orientation == Orientation.landscape;
    PreferredSizeWidget appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(CupertinoIcons.add),
                  onTap: () {
                    startNewTransaction(context);
                  },
                )
              ],
            ),
          ) as PreferredSizeWidget
        : AppBar(
            title: const Text('Flutter App'),
            actions: [
              IconButton(
                  onPressed: () {
                    startNewTransaction(context);
                  },
                  icon: const Icon(Icons.add)),
            ],
          );
    final double _frameInsetY =
        appbar.preferredSize.height + mediaQueryData.padding.top;
    final Size _screenSize = mediaQueryData.size;
    final double _availableHeight = _screenSize.height - _frameInsetY;
    var _chart = SizedBox(
      height: isInLandscape ? _availableHeight * .8 : _availableHeight * .3,
      child: Chart(recentTransactions),
    );
    var _transactionList = SizedBox(
      height: isInLandscape ? _availableHeight * .8 : _availableHeight * .7,
      child: TransactionList(userTransactions, _deleteTransaction),
    );
    final Widget _pageBody = SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isInLandscape)
            SizedBox(
              height: _availableHeight * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Show Chart'),
                  Switch(
                    activeColor: Theme.of(context).colorScheme.primary,
                    activeTrackColor: Theme.of(context).colorScheme.secondary,
                    inactiveThumbColor: Theme.of(context).colorScheme.error,
                    inactiveTrackColor: Theme.of(context).colorScheme.error,
                    value: showChart,
                    onChanged: (newValue) {
                      setState(() => showChart = newValue);
                    },
                  ),
                ],
              ),
            ),
          if (isInLandscape)
            if (showChart) _chart else _transactionList
          else ...[_chart, _transactionList]
        ],
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appbar as ObstructingPreferredSizeWidget,
            child: _pageBody)
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: appbar,
            body: _pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: kIsWeb || Platform.isAndroid
                ? FloatingActionButton(
                    onPressed: () {
                      startNewTransaction(context);
                    },
                    child: const Icon(Icons.add),
                  )
                : null,
          );
  }
}
