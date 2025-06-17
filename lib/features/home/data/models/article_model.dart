class ArticleModel {
  int? id;
  int? categoryId;
  int? userId;
  String? title;
  String? description;
  String? image;
  dynamic pdf;
  String? hyperlink;
  String? isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;

  ArticleModel({
    this.id,
    this.categoryId,
    this.userId,
    this.title,
    this.description,
    this.image,
    this.pdf,
    this.hyperlink,
    this.isFeatured,
    this.createdAt,
    this.updatedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json['id'] as int?,
        categoryId: json['category_id'] as int?,
        userId: json['user_id'] as int?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        image: json['image'] as String?,
        pdf: json['pdf'] as dynamic,
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
        'image': image,
        'pdf': pdf,
        'hyperlink': hyperlink,
        'is_featured': isFeatured,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
