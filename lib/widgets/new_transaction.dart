// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  const NewTransaction(this.addTx, {Key? key}) : super(key: key);

  final void Function(String, double, DateTime)? addTx;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController titleController = TextEditingController();
  DateTime? currentTime;
  final TextEditingController amountController = TextEditingController();

  void _submitTransaction() {
    final titleEntry = titleController.text;
    final amountEntry = double.parse(amountController.text);
    if (titleEntry.isEmpty || amountEntry <= 0) {
      return;
    }
    widget.addTx!(titleEntry, amountEntry, currentTime ?? DateTime.now());
    Navigator.of(context).pop();
  }

  void _getTransactionDate() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(
          Duration(
            days: 10000,
          ),
        ),
        lastDate: DateTime.now().add(
          Duration(
            days: 100000,
          ),
        )).then((value) => setState(() {
          currentTime = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: "Title"),
            style: Theme.of(context).textTheme.subtitle2,
            controller: titleController,
            keyboardType: TextInputType.text,
          ),
          TextField(
            decoration: const InputDecoration(labelText: "Amount"),
            style: Theme.of(context).textTheme.subtitle2,
            controller: amountController,
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: true),
            onSubmitted: (_) => _submitTransaction(),
          ),
          SizedBox(
            height: 70,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    currentTime == null
                        ? 'No Date Chosen'
                        : 'Transaction Date: ${DateFormat.yMd().format(currentTime!)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  onPressed: () => _getTransactionDate(),
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _submitTransaction,
            style: ElevatedButton.styleFrom(
              elevation: 5,
              textStyle: TextStyle(
                color: Theme.of(context).textTheme.button?.color,
              ),
            ),
            child: Text("Add Transaction"),
          )
        ],
      ),
    );
  }
}
