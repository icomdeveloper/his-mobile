import 'sender.dart';

class NotifcationModel {
  int? id;
  String? title;
  String? body;
  String? route;
  int? senderId;
  int? receiverId;
  dynamic articleId;
  dynamic mediaId;
  int? seen;
  DateTime? createdAt;
  DateTime? updatedAt;
  Sender? sender;

  NotifcationModel({
    this.id,
    this.title,
    this.body,
    this.route,
    this.senderId,
    this.receiverId,
    this.articleId,
    this.mediaId,
    this.seen,
    this.createdAt,
    this.updatedAt,
    this.sender,
  });

  factory NotifcationModel.fromJson(Map<String, dynamic> json) {
    return NotifcationModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      body: json['body'] as String?,
      route: json['route'] as String?,
      senderId: json['sender_id'] as int?,
      receiverId: json['receiver_id'] as int?,
      articleId: json['article_id'] as dynamic,
      mediaId: json['media_id'] as dynamic,
      seen: json['seen'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      sender: json['sender'] == null
          ? null
          : Sender.fromJson(json['sender'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'body': body,
        'route': route,
        'sender_id': senderId,
        'receiver_id': receiverId,
        'article_id': articleId,
        'media_id': mediaId,
        'seen': seen,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'sender': sender?.toJson(),
      };
}
