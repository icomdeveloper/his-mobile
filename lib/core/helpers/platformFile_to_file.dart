import 'dart:io';

import 'package:file_picker/file_picker.dart';

File? platformFileToFile(PlatformFile? platformFile) {
  if (platformFile == null) return null;

  if (platformFile.path == null) return null; // Not available on web
  return File(platformFile.path!);
}
