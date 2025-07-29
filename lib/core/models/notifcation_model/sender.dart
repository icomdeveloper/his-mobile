class Sender {
  int? id;
  String? name;
  String? email;
  String? profileImage;
  String? phone;
  dynamic emailVerifiedAt;
  String? role;
  dynamic googleId;
  dynamic appleId;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fcmToken;

  Sender({
    this.id,
    this.name,
    this.email,
    this.profileImage,
    this.phone,
    this.emailVerifiedAt,
    this.role,
    this.googleId,
    this.appleId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.fcmToken,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        profileImage: json['profile_image'] as String?,
        phone: json['phone'] as String?,
        emailVerifiedAt: json['email_verified_at'] as dynamic,
        role: json['role'] as String?,
        googleId: json['google_id'] as dynamic,
        appleId: json['apple_id'] as dynamic,
        deletedAt: json['deleted_at'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        fcmToken: json['fcm_token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'profile_image': profileImage,
        'phone': phone,
        'email_verified_at': emailVerifiedAt,
        'role': role,
        'google_id': googleId,
        'apple_id': appleId,
        'deleted_at': deletedAt,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'fcm_token': fcmToken,
      };
}
