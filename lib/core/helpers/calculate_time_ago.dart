import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

String getRelativeTime(DateTime dateTime) {
  final now = DateTime.now();
  return timeago.format(dateTime, clock: now);
}

String getCustomDate(DateTime dateTime) {
  return DateFormat('d MMM, y').format(dateTime);
}
