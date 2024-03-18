import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String timeAgo({bool numericDates = true}) {
    final date2 = DateTime.now();
    final difference = date2.difference(this);

    if ((difference.inDays / 30.5).floor() >= 12) {
      return (numericDates) ? '1 Year ago' : 'Last year';
    } else if ((difference.inDays / 30).floor() >= 1) {
      return (numericDates) ? '1 Month ago' : 'Last month';
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} Days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 Day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} Hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 Hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} Minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 Minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} Seconds ago';
    } else {
      return 'Just now';
    }
  }

  String getTime() {
    final DateFormat formatter = DateFormat('hh:mm a');
    return formatter.format(this);
  }
}
