import 'package:his/features/authentication/data/models/user_data/user_information.dart';

class ReplyModel {
  int? id;
  int? userId;
  int? mediaId;
  int? parentId;
  String? content;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserInformation? user;
  bool? isLiked;
  List<ReplyModel>? secondReplies;

  ReplyModel(
      {this.id,
      this.userId,
      this.mediaId,
      this.parentId,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.isLiked,
      this.secondReplies});

  factory ReplyModel.fromJson(Map<String, dynamic> json) => ReplyModel(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        mediaId: json['media_id'] as int?,
        parentId: json['parent_id'] as int?,
        content: json['content'] as String?,
        isLiked: json['is_liked'] as bool?,
        secondReplies: json['replies'] == null
            ? null
            : List<ReplyModel>.from(
                json['replies'].map((x) => ReplyModel.fromJson(x))),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        user: json['user'] == null
            ? null
            : UserInformation.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'media_id': mediaId,
        'parent_id': parentId,
        'is_liked': isLiked,
        'content': content,
        'replies': secondReplies?.map((e) => e.toJson()).toList(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user': user?.toJson(),
      };
}
