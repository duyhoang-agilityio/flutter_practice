import 'package:intl/intl.dart';

// Extension for string manipulation and formatting
extension StringExtensions on String {
  // Capitalize the first letter of the string
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  // Check if the string is a valid email
  bool isValidEmail() {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(this);
  }

  // Convert a string to Title Case
  String toTitleCase() {
    return toLowerCase().split(' ').map((word) => word.capitalize()).join(' ');
  }

  // Check if the string is a numeric value
  bool isNumeric() {
    return double.tryParse(this) != null;
  }

  // Convert a string to a DateTime object
  DateTime? toDateTime({String format = 'yyyy-MM-dd'}) {
    try {
      final dateFormat = DateFormat(format);
      return dateFormat.parse(this);
    } catch (e) {
      return null;
    }
  }

  // Remove whitespace from both ends of the string
  String trimWhitespace() {
    return trim();
  }

  // Checks if the string is null or empty.
  bool get isNullOrEmpty => isEmpty;

  // Formats the string as currency
  String formatCurrency({String locale = 'en_US', String symbol = '\$'}) {
    final number = double.tryParse(this);
    if (number == null) return this;
    final format = NumberFormat.currency(locale: locale, symbol: symbol);
    return format.format(number);
  }
}
