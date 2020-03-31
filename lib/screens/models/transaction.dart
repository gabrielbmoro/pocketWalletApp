import 'package:flutter/cupertino.dart';
import 'package:pocketwallet/screens/util/date.dart';

enum TransactionType { INCOME, EXPENSE, UNDEFINED }

class Transaction {
  String description;
  double value;
  TransactionType type;
  int month = currentMonth();
  int year = currentYear();

  Transaction({@required this.value, this.type, this.description, this.month, this.year});
}
