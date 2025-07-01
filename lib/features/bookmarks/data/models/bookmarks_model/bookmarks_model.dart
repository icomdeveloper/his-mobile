import 'item.dart';

class BookmarksModel {
  int? id;
  dynamic articleId;
  int? mediaId;
  String? flag;
  Item? item;
  DateTime? createdAt;
  DateTime? updatedAt;

  BookmarksModel({
    this.id,
    this.articleId,
    this.mediaId,
    this.flag,
    this.item,
    this.createdAt,
    this.updatedAt,
  });

  factory BookmarksModel.fromJson(Map<String, dynamic> json) {
    return BookmarksModel(
      id: json['id'] as int?,
      articleId: json['article_id'] as dynamic,
      mediaId: json['media_id'] as int?,
      flag: json['flag'] as String?,
      item: json['item'] == null
          ? null
          : Item.fromJson(json['item'] as Map<String, dynamic>),
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
        'item': item?.toJson(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
