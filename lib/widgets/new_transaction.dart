import 'dart:ffi';

import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  NewTransaction(this.addTx, {Key? key}) : super(key: key);

  final void Function(String, double)? addTx;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  void submitTransaction(){
    final titleEntry = titleController.text;
    final amountEntry = double.parse(amountController.text);
    if(titleEntry.isEmpty || amountEntry>=0) {
      return;
    }
    addTx!(titleEntry,amountEntry);
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
              onSubmitted: (_)=>submitTransaction(),
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
