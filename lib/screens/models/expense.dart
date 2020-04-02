import 'package:flutter/material.dart';
import 'expense_type.dart';
import 'transaction.dart';

class Expense extends Transaction {

  ExpenseType expenseType;

  Expense(ExpenseType expenseType, double value, int month, int year){
    this.expenseType = expenseType;
    super.value = value;
    super.month = month;
    super.year = year;
  }

  @override
  String description() {
    return expenseType.description;
  }

  @override
  Color color() {
    return Colors.red;
  }

  @override
  IconData icon() {
    return Icons.call_missed_outgoing;
  }

}