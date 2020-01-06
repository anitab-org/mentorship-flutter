import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String toDateString() {
    final formatter = DateFormat('dd MMM yyyy');
    return formatter.format(this);
  }

  /// Returns DateTime from timestamp expressed as seconds
  static DateTime fromTimestamp(double timestamp) {
    return DateTime.fromMillisecondsSinceEpoch((timestamp * 1000).toInt());
  }

  int toTimestamp() {
    return (this.millisecondsSinceEpoch / 1000).round();
  }
}
