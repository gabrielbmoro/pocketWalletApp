import 'package:flutter/material.dart';
import 'package:pocketwallet/models/transaction.dart';
import 'package:pocketwallet/util/media_query.dart';
import 'custom_painter.dart';

class WalletReport extends StatefulWidget {
  List<PocketWalletTransaction> _transactions;

  WalletReport(this._transactions);

  @override
  _WalletReportState createState() => _WalletReportState(_transactions);
}

class _WalletReportState extends State<WalletReport>
    with SingleTickerProviderStateMixin {
  final int _animationDuration = 3000;
  final double _height = 180.0;

  double _fraction = 0.0;
  Animation<double> _animation;
  List<PocketWalletTransaction> _transactions;

  _WalletReportState(this._transactions);

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
          _transactions,
          _fraction,
        ),
      ),
    );
  }
}
