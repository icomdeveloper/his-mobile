import 'dart:io';

import 'package:his/core/utils/api_endpoints.dart';

class UploadArticleModel {
  final int userId;
  final String title;
  final String description;
  final String year;
  final String month;
  final File? pdfFile;
  final File? imageFile;
  final int? isFeatured;
  final String? hyperlink;

  UploadArticleModel(
      {required this.userId,
      required this.title,
      required this.description,
      required this.year,
      required this.month,
      this.imageFile,
      this.pdfFile,
      this.hyperlink,
      this.isFeatured});
  toJson() => {
        ApiEndpoints.userId: userId,
        ApiEndpoints.title: title,
        ApiEndpoints.description: description,
        ApiEndpoints.pdf: pdfFile,
        ApiEndpoints.isFeatured: isFeatured,
        ApiEndpoints.year: year,
        ApiEndpoints.month: month,
        ApiEndpoints.imagePath: imageFile,
        ApiEndpoints.hyperlink: hyperlink
      };
}
