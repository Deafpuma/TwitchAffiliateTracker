import 'package:intl/intl.dart';

class Utils {
  static String formatTimestamp(DateTime timestamp) {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);
  }
}
