import 'dart:io';

import 'package:his/core/utils/api_endpoints.dart';

class UploadVideoModel {
  final int userId;
  final String year;
  final String month;
  final String title;
  final String description;
  final File? videoFile;
  final File? thumbnailFile;
  final File? pdfFile;
  final File? imageFile;
  final List<String>? mention;
  final int? isFeatured;

  UploadVideoModel(
      {required this.userId,
      required this.year,
      required this.title,
      required this.description,
      required this.videoFile,
      required this.month,
      this.mention,
      this.imageFile,
      required this.thumbnailFile,
      this.pdfFile,
      this.isFeatured});
  toJson() => {
        ApiEndpoints.userId: userId,
        ApiEndpoints.year: year,
        ApiEndpoints.month: month,
        ApiEndpoints.title: title,
        ApiEndpoints.description: description,
        ApiEndpoints.file: videoFile,
        ApiEndpoints.thumbnail: thumbnailFile,
        ApiEndpoints.mention: mention,
        ApiEndpoints.pdf: pdfFile,
        ApiEndpoints.isFeatured: isFeatured,
        ApiEndpoints.imagePath: imageFile
      };
}
