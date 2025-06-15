import 'dart:io';

import 'package:his/core/utils/api_endpoints.dart';

class UploadVideoModel {
  final int userId;
  final int categoryId;
  final String title;
  final String description;
  final File videoFile;
  final File thumbnailFile;
  final File? pdfFile;
  final bool? isFeatured;

  UploadVideoModel(
      {required this.userId,
      required this.categoryId,
      required this.title,
      required this.description,
      required this.videoFile,
      required this.thumbnailFile,
      this.pdfFile,
      this.isFeatured});
  toJson() => {
        ApiEndpoints.userId: userId,
        ApiEndpoints.categoryId: categoryId,
        ApiEndpoints.title: title,
        ApiEndpoints.description: description,
        ApiEndpoints.file: videoFile,
        ApiEndpoints.thumbnail: thumbnailFile,
        ApiEndpoints.pdf: pdfFile
      };
}
