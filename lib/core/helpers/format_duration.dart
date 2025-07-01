String formatDuration(String rawDuration) {
  try {
    // Split the string by colon
    List<String> parts = rawDuration.split('.');

    // Handle cases where format is unexpected
    if (parts.length < 2) return rawDuration;

    // Extract minutes and seconds
    String minutes = parts[0];
    String seconds = parts[1];

    // If seconds part is too long, take only the first 2 digits
    if (seconds.length > 2) {
      seconds = seconds.substring(0, 2);
    }

    return '$minutes:$seconds';
  } catch (e) {
    return rawDuration; // Fallback to original if parsing fails
  }
}
