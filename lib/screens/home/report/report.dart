import 'package:flutter/material.dart';
import 'package:pocketwallet/screens/models/expense.dart';
import 'package:pocketwallet/screens/models/expense_type.dart';
import 'package:pocketwallet/screens/models/income.dart';
import 'package:pocketwallet/screens/models/transaction.dart';

class Report extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: CustomPaint(
        painter: LineReportChart(),
      ),
    );
  }
}

class LineReportChart extends CustomPainter {
  List<Transaction> transactionList = [
    Income('aisdjij', 100.0, 1, 20),
    Income('aisdjij', 100.0, 1, 20),
    Expense(ExpenseType.TRANSPORT, 900.0, 1, 20),
    Income('aisdjij', 100.0, 1, 20),
    Income('asdasd', 100.0, 1, 20),
  ];

  final double barHeight = 48.0;
  final double marginStart = 24.0;
  final double marginTop = 48.0;
  final double maxBarWidth = 500.0;
  final double marginSpaceBetweenTheLines = 8;
  final double strokeWidth = 4;

  @override
  void paint(Canvas canvas, Size size) {

    double totalExpensesValue = 0.0;
    double totalIncomeValue = 0.0;

    int x = 0;
    while (x < transactionList.length) {
      Transaction t = transactionList[x];
      if (t is Income)
        totalIncomeValue += t.value;
      else if (t is Expense) totalExpensesValue += t.value;
      x++;
    }

   drawRect(
      x0: marginStart,
      y0: marginTop,
      totalValue: totalExpensesValue,
      canvas: canvas,
      rectColor: Colors.red,
    );

    drawRect(
      x0: marginStart,
      y0: marginTop + barHeight + marginSpaceBetweenTheLines,
      totalValue: totalIncomeValue,
      canvas: canvas,
      rectColor: Colors.green,
    );
  }

  void drawRect(
      {@required double x0,
      @required double y0,
      @required double totalValue,
      @required Canvas canvas,
      @required Color rectColor}) {
    Offset off1 = Offset(x0, y0);
    Offset off2 = Offset((totalValue / maxBarWidth) * 100.0, barHeight+y0);
    canvas.drawRect(
      Rect.fromPoints(off1, off2),
      Paint()
        ..color = rectColor
        ..strokeWidth = strokeWidth,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
