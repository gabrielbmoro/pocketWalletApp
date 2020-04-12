import 'package:flutter/material.dart';
import 'package:pocketwallet/models/expense_type.dart';

class ExpenseOptions extends StatefulWidget {
  ExpenseOptions({Key key}) : super(key: key);

  @override
  ExpenseOptionsState createState() => ExpenseOptionsState();
}

class ExpenseOptionsState extends State<ExpenseOptions> {
  ExpenseType expenseType = ExpenseType.values[0];

  List<DropdownMenuItem<ExpenseType>> _expenseTypeValues =
      ExpenseType.values.map(
    (item) {
      return DropdownMenuItem<ExpenseType>(
        value: item,
        child: Text(item.description),
      );
    },
  ).toList();

  @override
  Widget build(BuildContext context) {
    return DropdownButton<ExpenseType>(
      underline: Container(
        height: 2,
        color: Colors.black45,
      ),
      style: TextStyle(
        fontSize: 24.0,
        color: Colors.black45,
      ),
      onChanged: (ExpenseType type) => {
        setState(() {
          this.expenseType = type;
        })
      },
      value: expenseType,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24.0,
      elevation: 16,
      items: _expenseTypeValues,
    );
  }
}
