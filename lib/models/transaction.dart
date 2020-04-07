import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pocketwallet/util/date.dart';

enum TransactionType { INCOME, EXPENSE }

abstract class PocketWalletTransaction {

  double value;
  TransactionType type;
  int month = currentMonth();
  int year = currentYear();

  String description();

  Color color();

  IconData icon();

}