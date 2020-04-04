import 'package:flutter/material.dart';
import 'package:pocketwallet/screens/models/expense.dart';
import 'package:pocketwallet/screens/models/expense_type.dart';
import 'package:pocketwallet/screens/models/income.dart';
import 'package:pocketwallet/screens/models/transaction.dart';
import 'package:pocketwallet/screens/util/media_query.dart';
import 'line_report_chart.dart';

class Report extends StatelessWidget {
  List<Transaction> _transactionList = [
    Income('aisdjij', 100.0, 1, 20),
    Income('aisdjij', 100.0, 1, 20),
    Expense(ExpenseType.TRANSPORT, 8000.0, 1, 20),
    Income('aisdjij', 4000.0, 1, 20),
    Income('asdasd', 100.0, 1, 20),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: LineReportChart(
          screenWidth(
            context,
          ),
          _transactionList,
        ),
      ),
    );
  }
}
