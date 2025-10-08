String formatImageUrl(String path) {
  const baseUrl = 'https://his.mc-apps.org/';

  if (path.startsWith('http')) {
    return path; 
  } else {
    return '$baseUrl$path';
  }
}
