import 'dart:ffi';

import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction(this.addTx, {Key? key}) : super(key: key);

  final void Function(String, double)? addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController amountController = TextEditingController();

  void submitTransaction(){
    final titleEntry = titleController.text;
    final amountEntry = double.parse(amountController.text);
    if(titleEntry.isEmpty || amountEntry<=0) {
      return;
    }
    widget.addTx!(titleEntry,amountEntry);
    Navigator.of(context).pop();


  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: "Title"),
              controller: titleController,
              keyboardType:
                  TextInputType.text,
            ),
            TextField(
              decoration: const InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType:
                  TextInputType.numberWithOptions(signed: false, decimal: true),
              onSubmitted:(_)=> submitTransaction(),
            ),
            FlatButton(
              onPressed: submitTransaction,
              child: const Text(
                "Add Transaction",
                style: TextStyle(color: Colors.purple),
              ),
            )
          ],
        ),
      ),
    );
  }
}
