import 'package:flutter/foundation.dart';

import 'transaction.dart';

class Income extends Transaction {
  String source;

  Income(String source, double value, int month, int year) {
    this.source = source;
    super.value = value;
    super.month = month;
    super.year = year;
  }

  @override
  String description() {
    return source;
  }

}
