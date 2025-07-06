class ArticleModel {
  int? id;
  int? categoryId;
  int? userId;
  String? title;
  String? description;
  String? image;
  String? thumbnailImage;

  String? pdf;
  String? mention;
  dynamic assignedTo;
  String? hyperlink;
  String? isFeatured;
  int? isFavourite;
  DateTime? createdAt;
  DateTime? updatedAt;

  ArticleModel({
    this.id,
    this.categoryId,
    this.userId,
    this.title,
    this.description,
    this.thumbnailImage,
    this.image,
    this.mention,
    this.assignedTo,
    this.pdf,
    this.hyperlink,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
    this.isFavourite,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json['id'] as int?,
        categoryId: json['category_id'] as int?,
        userId: json['user_id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        assignedTo: json['assigned_to'] as dynamic,
        mention: json['mention'] as String?,
        image: json['image_path'] as String?,
        thumbnailImage: json['thumbnail_path'] as String?,
        pdf: json['pdf'] as String?,
        isFavourite: json['is_favourite'] as int?,
        hyperlink: json['hyperlink'] as String?,
        isFeatured: json['is_featured'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'user_id': userId,
        'title': title,
        'description': description,
        'image_path': image,
        'mention': mention,
        'thumbnail_path': thumbnailImage,
        'assigned_to': assignedTo,
        'pdf': pdf,
        'is_favourite': isFavourite,
        'hyperlink': hyperlink,
        'is_featured': isFeatured,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  factory ArticleModel.fromArticle(ArticleModel bookmark) => ArticleModel(
        id: bookmark.id,
        categoryId: bookmark.categoryId,
        userId: bookmark.userId,
        title: bookmark.title,
        description: bookmark.description,
        thumbnailImage: bookmark.thumbnailImage,
        isFavourite: bookmark.isFavourite,
        mention: bookmark.mention,
        assignedTo: bookmark.assignedTo,
        pdf: bookmark.pdf,
        image: bookmark.image,
        isFeatured: bookmark.isFeatured.toString(),
        hyperlink: bookmark.hyperlink,
        createdAt:
            bookmark.createdAt == null ? null : bookmark.createdAt as DateTime,
        updatedAt:
            bookmark.updatedAt == null ? null : bookmark.updatedAt as DateTime,
      );
}
