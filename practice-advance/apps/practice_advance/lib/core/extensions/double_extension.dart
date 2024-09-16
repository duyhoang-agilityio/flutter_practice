import 'package:intl/intl.dart';

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(toStringAsFixed(fractionDigits));
  }

  double nonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }

  String toCurrency({String locale = 'en_US', String symbol = '\$'}) {
    final format = NumberFormat.currency(locale: locale, symbol: symbol);
    return format.format(this);
  }
}
