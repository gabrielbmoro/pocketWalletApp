import 'package:flutter/material.dart';
import 'package:pocketwallet/screens/models/expense.dart';
import 'package:pocketwallet/screens/models/expense_type.dart';
import 'package:pocketwallet/screens/models/income.dart';
import 'package:pocketwallet/screens/models/transaction.dart';
import 'package:pocketwallet/screens/util/media_query.dart';
import 'custom_painter.dart';

class WalletReport extends StatefulWidget {
  @override
  _WalletReportState createState() => _WalletReportState();
}

class _WalletReportState extends State<WalletReport>
    with SingleTickerProviderStateMixin {
  final int _animationDuration = 3000;

  double _fraction = 0.0;
  Animation<double> animation;
  List<Transaction> _transactionList = [
    Income('aisdjij', 160.0, 1, 20),
    Expense(ExpenseType.TRANSPORT, 80.0, 1, 20),
  ];

  @override
  void initState() {
    super.initState();
    var controller = AnimationController(
        duration: Duration(
          milliseconds: _animationDuration,
        ),
        vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _fraction = animation.value;
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: LineChartPainter(
            screenWidth(
              context,
            ),
            _transactionList,
            _fraction),
      ),
    );
  }
}
