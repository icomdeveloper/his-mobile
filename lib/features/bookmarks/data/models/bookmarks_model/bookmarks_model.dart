import 'package:his/features/category/data/model/media_model.dart';
import 'package:his/features/home/data/models/article_model.dart';

class BookmarksModel {
  int? id;
  dynamic articleId;
  int? mediaId;
  String? flag;
  MediaModel? mediaModel;
  ArticleModel? articleModel;
  DateTime? createdAt;
  DateTime? updatedAt;

  BookmarksModel({
    this.id,
    this.articleId,
    this.mediaId,
    this.flag,
    this.articleModel,
    this.mediaModel,
    this.createdAt,
    this.updatedAt,
  });

  factory BookmarksModel.fromJsonToMedia(Map<String, dynamic> json) {
    return BookmarksModel(
      id: json['id'] as int?,
      articleId: json['article_id'] as dynamic,
      mediaId: json['media_id'] as int?,
      flag: json['flag'] as String?,
      mediaModel: json['media'] == null
          ? null
          : MediaModel.fromJson(json['media'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );
  }
  factory BookmarksModel.fromJsonToArticle(Map<String, dynamic> json) {
    return BookmarksModel(
      id: json['id'] as int?,
      articleId: json['article_id'] as dynamic,
      mediaId: json['media_id'] as int?,
      flag: json['flag'] as String?,
      articleModel: json['article'] == null
          ? null
          : ArticleModel.fromJson(json['article'] as Map<String, dynamic>),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'article_id': articleId,
        'media_id': mediaId,
        'flag': flag,
        'article': articleModel?.toJson(),
        'media': mediaModel?.toJson(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
