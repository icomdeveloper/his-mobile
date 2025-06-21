import 'package:his/core/utils/api_endpoints.dart';

class AddCommentModel {
  final int mediaId;
  final int userId;
  final int? parentId;
  final String content;

  const AddCommentModel({
    required this.mediaId,
    required this.userId,
    this.parentId,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        ApiEndpoints.mediaId: mediaId,
        ApiEndpoints.userId: userId,
        ApiEndpoints.parentId: parentId,
        ApiEndpoints.content: content,
      };
}
