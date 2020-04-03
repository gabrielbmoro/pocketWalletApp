import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pocketwallet/screens/models/expense.dart';
import 'package:pocketwallet/screens/models/expense_type.dart';
import 'package:pocketwallet/screens/models/income.dart';
import 'package:pocketwallet/screens/models/transaction.dart';
import 'package:pocketwallet/screens/util/currency.dart';
import 'package:pocketwallet/screens/util/media_query.dart';

class Report extends StatelessWidget {
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
        ),
      ),
    );
  }
}

class LineReportChart extends CustomPainter {
  List<Transaction> transactionList = [
    Income('aisdjij', 100.0, 1, 20),
    Income('aisdjij', 100.0, 1, 20),
    Expense(ExpenseType.TRANSPORT, 1200.0, 1, 20),
    Income('aisdjij', 4000.0, 1, 20),
    Income('asdasd', 100.0, 1, 20),
  ];

  final double barHeight = 48.0;
  final double horizontalMargin = 24.0;
  final double marginTop = 48.0;
  final double marginSpaceBetweenTheLines = 8;
  final double strokeWidth = 4;
  final double screenWidth;

  LineReportChart(this.screenWidth);

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

    drawRectMaxWidth(
      x0: horizontalMargin,
      y0: marginTop,
      canvas: canvas,
      rectColor: Colors.grey[300],
    );

    drawRectMaxWidth(
      x0: horizontalMargin,
      y0: marginTop + barHeight + marginSpaceBetweenTheLines,
      canvas: canvas,
      rectColor: Colors.grey[300],
    );

    drawRect(
      x0: horizontalMargin,
      y0: marginTop,
      totalValue: totalExpensesValue,
      canvas: canvas,
      rectColor: Colors.red,
    );

    drawRect(
      x0: horizontalMargin,
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
    Offset off0 = Offset(x0, y0);

    double x1 = (totalValue / getMaxBarWidth()) * 100.0;
    if(x1 > getMaxBarWidth())
      x1 = getMaxBarWidth();

    double y1 = barHeight + y0;
    Offset off1 = Offset(x1, y1);

    canvas.drawRect(
      Rect.fromPoints(off0, off1),
      Paint()
        ..color = rectColor
        ..strokeWidth = strokeWidth,
    );

    drawBarLabel(totalValue, off0, off1, canvas);
  }

  void drawBarLabel(double totalValue, Offset off0, Offset off1, Canvas canvas) {
    TextSpan span = new TextSpan(
        style: new TextStyle(
          color: Colors.white,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
        text: convertToCurrencyFormat(totalValue),);
    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    double offSetLabelY = ((off0.dy + off1.dy) / 2);
    Offset offSetLabel = Offset(off0.dx + 12, offSetLabelY - 12);
    tp.layout();
    tp.paint(canvas, offSetLabel);
  }

  void drawRectMaxWidth(
      {@required double x0,
      @required double y0,
      @required Canvas canvas,
      @required Color rectColor}) {
    Offset off1 = Offset(x0, y0);
    Offset off2 = Offset(getMaxBarWidth(), barHeight + y0);
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

  double getMaxBarWidth() {
    return screenWidth - horizontalMargin;
  }
}
