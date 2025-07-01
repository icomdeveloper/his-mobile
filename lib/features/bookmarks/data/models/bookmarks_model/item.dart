class Item {
  int? id;
  int? categoryId;
  int? userId;
  String? subCategoryId;
  String? title;
  String? views;
  dynamic description;
  String? filePath;
  dynamic assignedTo;
  String? mention;
  String? duration;
  String? pdf;
  String? thumbnailPath;
  String? imagePath;
  String? status;
  int? isFeatured;
  int? isFavorite;
  DateTime? createdAt;
  DateTime? updatedAt;

  Item({
    this.id,
    this.categoryId,
    this.userId,
    this.subCategoryId,
    this.title,
    this.views,
    this.description,
    this.filePath,
    this.assignedTo,
    this.mention,
    this.duration,
    this.pdf,
    this.thumbnailPath,
    this.imagePath,
    this.status,
    this.isFeatured,
    this.isFavorite,
    this.createdAt,
    this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json['id'] as int?,
        categoryId: json['category_id'] as int?,
        userId: json['user_id'] as int?,
        subCategoryId: json['sub_category_id'] as String?,
        title: json['title'] as String?,
        views: json['views'] as String?,
        description: json['description'] as dynamic,
        filePath: json['file_path'] as String?,
        assignedTo: json['assigned_to'] as dynamic,
        mention: json['mention'] as String?,
        duration: json['duration'] as String?,
        pdf: json['pdf'] as String?,
        thumbnailPath: json['thumbnail_path'] as String?,
        imagePath: json['image_path'] as String?,
        status: json['status'] as String?,
        isFeatured: json['is_featured'] as int?,
        isFavorite: json['is_favorite'] as int?,
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
        'sub_category_id': subCategoryId,
        'title': title,
        'views': views,
        'description': description,
        'file_path': filePath,
        'assigned_to': assignedTo,
        'mention': mention,
        'duration': duration,
        'pdf': pdf,
        'thumbnail_path': thumbnailPath,
        'image_path': imagePath,
        'status': status,
        'is_featured': isFeatured,
        'is_favorite': isFavorite,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
