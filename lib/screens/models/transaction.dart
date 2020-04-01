import 'package:flutter/foundation.dart';
import 'package:pocketwallet/screens/util/date.dart';

enum TransactionType { INCOME, EXPENSE, UNDEFINED }

abstract class Transaction {
  double value;
  TransactionType type;
  int month = currentMonth();
  int year = currentYear();

  String description();
}