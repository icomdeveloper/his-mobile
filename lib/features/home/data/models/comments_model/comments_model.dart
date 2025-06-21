import 'package:his/features/authentication/data/models/user_data/user_information.dart';

import 'reply_model.dart';

class CommentsModel {
  int? id;
  int? userId;
  int? mediaId;
  dynamic parentId;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<ReplyModel>? replies;
  UserInformation? user;

  CommentsModel({
    this.id,
    this.userId,
    this.mediaId,
    this.parentId,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.replies,
    this.user,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        mediaId: json['media_id'] as int?,
        parentId: json['parent_id'] as dynamic,
        content: json['content'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        replies: (json['replies'] as List<dynamic>?)
            ?.map((e) => ReplyModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        user: json['user'] == null
            ? null
            : UserInformation.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'media_id': mediaId,
        'parent_id': parentId,
        'content': content,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'replies': replies?.map((e) => e.toJson()).toList(),
        'user': user?.toJson(),
      };
}
