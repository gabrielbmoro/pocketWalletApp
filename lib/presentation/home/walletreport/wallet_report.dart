import 'package:flutter/material.dart';
import 'package:pocketwallet/models/transaction.dart';
import 'package:pocketwallet/util/media_query.dart';
import 'custom_painter.dart';

class WalletReport extends StatefulWidget {
  List<PocketWalletTransaction> _transactions;

  WalletReport(Key key, this._transactions) : super(key: key);

  @override
  WalletReportState createState() => WalletReportState(_transactions);
}

class WalletReportState extends State<WalletReport>
    with SingleTickerProviderStateMixin {
  final int _animationDuration = 3000;
  final double _height = 180.0;

  double _fraction = 0.0;
  Animation<double> _animation;
  AnimationController _controller;
  List<PocketWalletTransaction> _transactions;

  WalletReportState(this._transactions);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(
          milliseconds: _animationDuration,
        ),
        vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });
    _controller.forward();
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

  void stopAnimation() {
    if (_controller != null) _controller.dispose();
  }
}
