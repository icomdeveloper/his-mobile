import 'package:timeago/timeago.dart' as timeago;

String getRelativeTime(DateTime dateTime) {
  final now = DateTime.now();
  return timeago.format(dateTime, clock: now);
}
