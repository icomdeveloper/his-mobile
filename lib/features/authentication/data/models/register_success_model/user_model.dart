class UserModel {
  String? name;
  String? email;
  String? role;
  String? username;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  UserModel({
    this.name,
    this.email,
    this.role,
    this.username,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json['name'] as String?,
        email: json['email'] as String?,
        role: json['role'] as String?,
        username: json['username'] as String?,
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'role': role,
        'username': username,
        'updated_at': updatedAt?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
        'id': id,
      };
}
