class Subcategory {
  int? id;
  String? name;
  String? description;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Subcategory({
    this.id,
    this.name,
    this.description,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json['id'] as int?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        categoryId: json['category_id'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'category_id': categoryId,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
