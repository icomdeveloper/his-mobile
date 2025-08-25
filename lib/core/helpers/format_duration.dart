import 'package:intl/intl.dart';

String formatDuration(String rawDuration) {
  try {
    // Convert string to double (seconds with decimals)
    double totalSeconds = double.parse(rawDuration);

    // Convert to minutes and seconds
    int minutes = totalSeconds ~/ 60;
    int seconds = (totalSeconds % 60).round();

    // Format with leading zeros for seconds
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  } catch (e) {
    return rawDuration; // Fallback if parsing fails
  }
}

String formatDate(DateTime dateTime) {
  final formatted = DateFormat("MMM dd, yyyy 'at' hh:mm a").format(dateTime);
  return formatted;
}

String formatDateWithoutTime(DateTime dateTime) {
  final formatted = DateFormat("MMM dd, yyyy").format(dateTime);
  return formatted;
}
