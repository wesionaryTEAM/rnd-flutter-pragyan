import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function(String, double, DateTime) _addTransaction;

  NewTransaction(this._addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget._addTransaction(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
        context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      _selectedDate = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
              onSubmitted: (_) => submitData,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              autocorrect: false,
              autofocus: true,
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
              onSubmitted: (_) => submitData,
            ),
            Row(
              children: [
                Text('No Date chosen'),
                TextButton(onPressed: _presentDatePicker, child: Text('Choose Date'))
              ],
            ),
            TextButton(
              onPressed: submitData,
              child: Text('Add Transaction'),
              style: ButtonStyle(),
            )
          ],
        ),
      ),
    );
  }
}
