import 'dart:math';
import 'dart:ui';
import 'package:pocketwallet/screens/models/expense.dart';
import 'package:pocketwallet/screens/models/income.dart';
import 'package:pocketwallet/screens/models/transaction.dart';
import 'package:pocketwallet/screens/util/currency.dart';
import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  // data to show
  final List<Transaction> _transactionList;

  // screen width
  final double _screenWidth;

  // animationController
  final double _fraction;

  //constants
  final double _barHeight = 48.0;
  final double _horizontalMargin = 24.0;
  final double _marginTop = 48.0;
  final double _marginSpaceBetweenTheLines = 8;
  final double _strokeWidth = 4;
  final Color _barDefaultBackground = Colors.grey[300];
  final Color _incomesBarBackground = Colors.green;
  final Color _expensesBarBackground = Colors.red;
  final Color _labelTextColor = Colors.white;
  final double _labelFontSize = 18.0;
  final double _labelMarginStart = 12.0;

  LineChartPainter(this._screenWidth, this._transactionList, this._fraction);

  @override
  void paint(Canvas canvas, Size size) {
    print('Fração -> $_fraction');
    double totalExpensesValue = 0.0;
    double totalIncomeValue = 0.0;

    _transactionList.forEach((t) => {
          if (t is Income)
            totalIncomeValue += t.value
          else if (t is Expense)
            totalExpensesValue += t.value
        });

    drawRectMaxWidth(
      x0: _horizontalMargin,
      y0: _marginTop,
      canvas: canvas,
      rectColor: _barDefaultBackground,
    );

    drawRectMaxWidth(
      x0: _horizontalMargin,
      y0: _marginTop + _barHeight + _marginSpaceBetweenTheLines,
      canvas: canvas,
      rectColor: _barDefaultBackground,
    );

    double maxValue = max(totalIncomeValue, totalExpensesValue);

    drawRect(
        x0: _horizontalMargin,
        y0: _marginTop,
        totalValue: totalExpensesValue,
        canvas: canvas,
        rectColor: _expensesBarBackground,
        maxValue: maxValue,
        currentFraction: _fraction,
    );

    drawRect(
      x0: _horizontalMargin,
      y0: _marginTop + _barHeight + _marginSpaceBetweenTheLines,
      totalValue: totalIncomeValue,
      canvas: canvas,
      rectColor: _incomesBarBackground,
      maxValue: maxValue,
      currentFraction: _fraction,
    );
  }

  void drawRect({
    @required double x0,
    @required double y0,
    @required double totalValue,
    @required Canvas canvas,
    @required Color rectColor,
    @required double maxValue,
    @required double currentFraction,
  }) {
    Offset off0 = Offset(x0, y0);

    double x1 = totalValue / maxValue == 1
        ? getMaxBarWidth()
        : (totalValue / maxValue) * getMaxBarWidth();
    double y1 = _barHeight + y0;
    Offset off1 = Offset(x1, y1);

    canvas.drawRect(
      Rect.fromPoints(off0, off1),
      Paint()
        ..color = rectColor
        ..strokeWidth = _strokeWidth,
    );

    drawBarLabel(totalValue, off0, off1, canvas);
  }

  void drawBarLabel(
    double totalValue,
    Offset off0,
    Offset off1,
    Canvas canvas,
  ) {
    TextSpan span = new TextSpan(
      style: new TextStyle(
        color: _labelTextColor,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        fontSize: _labelFontSize,
      ),
      text: convertToCurrencyFormat(totalValue),
    );

    TextPainter tp = new TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    double offSetLabelY = ((off0.dy + off1.dy) / 2);
    Offset offSetLabel = Offset(
        off0.dx + _labelMarginStart, offSetLabelY - (_labelFontSize / 2.0));

    tp.layout();

    tp.paint(canvas, offSetLabel);
  }

  void drawRectMaxWidth({
    @required double x0,
    @required double y0,
    @required Canvas canvas,
    @required Color rectColor,
  }) {
    Offset off1 = Offset(x0, y0);
    Offset off2 = Offset(getMaxBarWidth(), _barHeight + y0);

    canvas.drawRect(
      Rect.fromPoints(off1, off2),
      Paint()
        ..color = rectColor
        ..strokeWidth = _strokeWidth,
    );
  }

  @override
  bool shouldRepaint(LineChartPainter oldDelegate) {
    return oldDelegate._fraction != _fraction;
  }

  double getMaxBarWidth() {
    return _screenWidth - _horizontalMargin;
  }
}