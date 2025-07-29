class MediaModel {
  int? id;
  int? categoryId;
  int? userId;
  String? title;
  String? views;
  String? description;
  String? filePath;
  String? pdf;
  String? thumbnailPath;
  String? mention;
  dynamic assignedTo;
  bool? isFavorite;
  String? status;
  String? duration;
  int? isFeatured;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? commentsCount;
  bool? isLiked;
  int? likesCount;
  String? image;

  MediaModel({
    this.id,
    this.categoryId,
    this.userId,
    this.title,
    this.views,
    this.description,
    this.filePath,
    this.pdf,
    this.thumbnailPath,
    this.status,
    this.isFeatured,
    this.isLiked,
    this.assignedTo,
    this.mention,
    this.isFavorite,
    this.createdAt,
    this.updatedAt,
    this.duration,
    this.commentsCount,
    this.likesCount,
    this.image,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) => MediaModel(
        id: json['id'] as int?,
        categoryId: json['category_id'] as int?,
        userId: json['user_id'] as int?,
        title: json['title'] as String?,
        views: json['views'] as String?,
        description: json['description'] as String?,
        filePath: json['file_path'] as String?,
        pdf: json['pdf'] as String?,
        duration: json['duration'] as String?,
        thumbnailPath: json['thumbnail_path'] as String,
        assignedTo: json['assigned_to'] as dynamic,
        mention: json['mention'] as String?,
        isFavorite: json['is_favorite'] as bool?,
        isLiked: json['is_liked'] as bool?,
        image: json['image_path'] as String?,
        commentsCount: json['comments_count'] as int?,
        likesCount: json['likes_count'] as int?,
        status: json['status'] as String?,
        isFeatured: json['is_featured'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );
  factory MediaModel.fromBookmarkJson(Map<String, dynamic> json) => MediaModel(
        id: json['id'] as int?,
        categoryId: json['category_id'] as int?,
        userId: json['user_id'] as int?,
        title: json['title'] as String?,
        views: json['views'] as String?,
        description: json['description'] as String?,
        filePath: json['file_path'] as String?,
        isLiked: json['is_liked'] as bool?,
        pdf: json['pdf'] as String?,
        duration: json['duration'] as String?,
        thumbnailPath: json['thumbnail_path'] as String,
        assignedTo: json['assigned_to'] as dynamic,
        mention: json['mention'] as String?,
        isFavorite: json['is_favorite'] as bool?,
        image: json['image_path'] as String?,
        commentsCount: json['comments_count'] as int?,
        likesCount: json['likes_count'] as int?,
        status: json['status'] as String?,
        isFeatured: json['is_featured'] as int?,
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
        'views': views,
        'description': description,
        'file_path': filePath,
        'pdf': pdf,
        'duration': duration,
        'thumbnail_path': thumbnailPath,
        'is_liked': isLiked,
        'image_path': image,
        'comments_count': commentsCount,
        'assigned_to': assignedTo,
        'mention': mention,
        'likes_count': likesCount,
        'status': status,
        'is_featured': isFeatured,
        'is_favorite': isFavorite,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
  factory MediaModel.fromMedia(MediaModel mediaModel) => MediaModel(
        id: mediaModel.id,
        categoryId: mediaModel.categoryId,
        userId: mediaModel.userId,
        title: mediaModel.title,
        commentsCount: mediaModel.commentsCount,
        likesCount: mediaModel.likesCount,
        views: mediaModel.views,
        description: mediaModel.description,
        assignedTo: mediaModel.assignedTo,
        mention: mediaModel.mention,
        isFavorite: mediaModel.isFavorite,
        filePath: mediaModel.filePath,
        isLiked: mediaModel.isLiked,
        pdf: mediaModel.pdf,
        duration: mediaModel.duration,
        thumbnailPath: mediaModel.thumbnailPath as String,
        image: mediaModel.image,
        status: mediaModel.status,
        isFeatured: mediaModel.isFeatured,
        createdAt: mediaModel.createdAt == null
            ? null
            : mediaModel.createdAt as DateTime,
        updatedAt: mediaModel.updatedAt == null
            ? null
            : mediaModel.updatedAt as DateTime,
      );
}
