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
  final double _height = 180.0;

  double _fraction = 0.0;
  Animation<double> _animation;
  List<Transaction> _transactionList = [
    Expense(ExpenseType.GYM, 120.0, 1, 20),
    Income('aisdjij', 120.0, 1, 20),
    Expense(ExpenseType.TRANSPORT, 120.0, 1, 20),
    Income('aisdjij', 120.0, 1, 20),
    Income('aisdjij', 120.0, 1, 20),
  ];

  @override
  void initState() {
    super.initState();
    var controller = AnimationController(
        duration: Duration(
          milliseconds: _animationDuration,
        ),
        vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double width = screenWidth(context);
    return Container(
      width: width,
      height: _height,
      child: CustomPaint(
        painter: LineChartPainter(
          width,
          _transactionList,
          _fraction,
        ),
      ),
    );
  }
}
