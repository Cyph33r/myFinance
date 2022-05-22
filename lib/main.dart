import 'package:flutter/material.dart';
import './transaction.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatelessWidget {
  final List transactions = <Transaction>[
    Transaction(id: 1, title: "New Shoes", amount: 69.99, time: DateTime.now())
  ];

  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: const [
            SizedBox(
              width: double.infinity,
              child: Card(
                child: Text("chart"),
                elevation: 5,
              ),
            ),
            Card(
              child: Text("List of transactions"),
            )
          ],
        ),
      ),
    );
  }
}
