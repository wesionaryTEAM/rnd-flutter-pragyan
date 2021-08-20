import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function(String, double) _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();

    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              autocorrect: false,
              autofocus: true,
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              autocorrect: false,
              autofocus: true,
              controller: amountController,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextButton(
              onPressed: () {
                _addTransaction(titleController.text, double.parse(amountController.text));
              },
              child: Text('Add Transaction'),
              style: ButtonStyle(),
            )
          ],
        ),
      ),
    );
  }
}
