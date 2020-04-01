import 'package:flutter/foundation.dart';

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
}