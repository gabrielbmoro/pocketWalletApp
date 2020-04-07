import 'package:flutter/material.dart';
import 'package:pocketwallet/models/expense_type.dart';

class ExpenseOptions extends StatefulWidget{
  @override
  _ExpenseOptionsState createState() => _ExpenseOptionsState();
}

class _ExpenseOptionsState extends State<ExpenseOptions> {

  ExpenseType _expenseType = ExpenseType.values[0];

  List<DropdownMenuItem<ExpenseType>> _expenseTypeValues =
  ExpenseType.values.map(
        (item) {
      return DropdownMenuItem<ExpenseType>(
          value: item, child: Text(item.description));
    },
  ).toList();

  @override
  Widget build(BuildContext context) {
    return DropdownButton<ExpenseType>(
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      style: TextStyle(color: Colors.deepPurple),
      onChanged: (ExpenseType expenseType) => {
        setState(() {
          _expenseType = expenseType;
        })
      },
      value: _expenseType,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      items: _expenseTypeValues,
    );
  }
}