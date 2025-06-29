String convertDrivePreviewToDirectImage(String previewUrl, {int width = 1000}) {
  final regex = RegExp(r'\/file\/d\/([^\/]+)');
  final match = regex.firstMatch(previewUrl);
  final fileId = match?.group(1);

  if (fileId == null) {
    return 'https://cdn.prod.website-files.com/6009ec8cda7f305645c9d91b/601082646d6bf4446451b0a4_6002086f72b72717ae01d954_google-doc-error-message.png';
  }

  // Return the direct image URL
  return 'https://lh3.googleusercontent.com/d/$fileId=w$width';
}

String getDirectVideoUrl(String previewUrl) {
  final regex = RegExp(r'/file/d/([^/]+)');
  final match = regex.firstMatch(previewUrl);
  final videoId = match?.group(1) ?? '';

  return 'https://drive.google.com/uc?export=view&id=$videoId';
}

String convertGoogleDriveUrl(String previewUrl) {
  // Extract the file ID using RegExp
  final RegExp regExp = RegExp(r'\/file\/d\/([^\/]+)');
  final match = regExp.firstMatch(previewUrl);

  if (match != null && match.groupCount >= 1) {
    String fileId = match.group(1)!;
    return "https://drive.google.com/uc?export=download&id=$fileId";
  } else {
    throw const FormatException("Invalid Google Drive URL");
  }
}
