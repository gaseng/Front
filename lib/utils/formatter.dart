import 'package:intl/intl.dart';

class Formatter {
  static String customFormatter(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }
}