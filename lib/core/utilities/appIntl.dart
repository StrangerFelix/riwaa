import 'package:intl/intl.dart';

class AppIntl {
  static String formatTime(int epoch) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(epoch * 1000);
    return DateFormat('h a').format(dateTime); // 'h a' -> e.g., '7 PM'
  }

  static int getCurrentHourEpoch() {
    DateTime now = DateTime.now();
    DateTime currentHour = DateTime(now.year, now.month, now.day, now.hour);
    return currentHour.millisecondsSinceEpoch ~/ 1000; // Convert to seconds
  }
}