import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function handleAddTransaction;

  NewTransaction(this.handleAddTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _handleSubmit() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.handleAddTransaction(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presenDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickDate) {
      if (pickDate == null) {
        return;
      }
      setState(() {
        this._selectedDate = pickDate;
      });
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
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _handleSubmit(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text(this._selectedDate == null
                      ? 'No Date Chosen!'
                      : DateFormat.yMMMd().format(this._selectedDate)),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.purple,
                    onPressed: () {
                      this._presenDatePicker();
                    },
                  )
                ],
              ),
            ),
            FlatButton(
                onPressed: _handleSubmit,
                child: Text('Add Transaction'),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }
}
