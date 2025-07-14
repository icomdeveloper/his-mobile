import 'subcategory.dart';

class Categories {
  int? id;
  int? userId;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Subcategory>? subcategories;

  Categories({
    this.id,
    this.userId,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.subcategories,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        subcategories: (json['subcategories'] as List<dynamic>?)
            ?.map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'name': name,
        'description': description,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'subcategories': subcategories?.map((e) => e.toJson()).toList(),
      };
}
