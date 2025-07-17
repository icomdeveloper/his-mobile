import 'dart:io';

import 'package:his/core/utils/api_endpoints.dart';

class EditMediaModel {
  final int userId;
  final int mediaId;
  final String year;
  final String month;
  final String? title;
  final String? description;
  final File? videoFile;
  final File? thumbnailFile;
  final File? pdfFile;
  final File? imageFile;

  EditMediaModel(
      {required this.userId,
      required this.mediaId,
      required this.year,
      required this.month,
      this.title,
      this.description,
      this.videoFile,
      this.thumbnailFile,
      this.pdfFile,
      this.imageFile});
  toJson() => {
        ApiEndpoints.userId: userId,
        ApiEndpoints.mediaId: mediaId,
        ApiEndpoints.year: year,
        ApiEndpoints.month: month,
        ApiEndpoints.title: title,
        ApiEndpoints.description: description,
        ApiEndpoints.file: videoFile,
        ApiEndpoints.thumbnail: thumbnailFile,
        ApiEndpoints.pdf: pdfFile,
        ApiEndpoints.imagePath: imageFile
      };
}
