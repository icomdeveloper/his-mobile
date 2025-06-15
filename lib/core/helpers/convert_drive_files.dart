// String convertDrivePreviewToDirectImage(String previewUrl, {int width = 1000}) {
//   final regex = RegExp(r'\/file\/d\/([^\/]+)');
//   final match = regex.firstMatch(previewUrl);
//   final fileId = match?.group(1);

//   if (fileId == null) {
//     throw ArgumentError('Invalid Google Drive preview URL');
//   }

//   // Return the direct image URL
//   return 'https://lh3.googleusercontent.com/d/$fileId=w$width';
// }

String getDirectVideoUrl(String previewUrl) {
  final regex = RegExp(r'/file/d/([^/]+)');
  final match = regex.firstMatch(previewUrl);
  final videoId = match?.group(1) ?? '';

  return 'https://drive.google.com/uc?export=view&id=$videoId';
}
