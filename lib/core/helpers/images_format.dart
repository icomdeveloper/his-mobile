String formatImageUrl(String path) {
  const baseUrl = 'https://his.mc-apps.org/';

  if (path.startsWith('http')) {
    return path; // Already a full URL
  } else {
    return '$baseUrl$path';
  }
}
