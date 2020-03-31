import 'dart:ui';

import 'package:intl/intl.dart';

String convertToCurrencyFormat(double valor) {
  return NumberFormat.simpleCurrency(locale: 'pt_BR').format(valor);
}
