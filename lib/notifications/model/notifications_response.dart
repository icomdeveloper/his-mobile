class NotificationResponse {
  String? message;
  NotificationData? data;

  NotificationResponse({this.message, this.data});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      message: json['message'],
      data: NotificationData.fromJson(json['data']),
    );
  }
}

class NotificationData {
  int? currentPage;
  List<NotificationItem>? notifications;
  String? nextPageUrl;
  int? total;

  NotificationData({
    this.currentPage,
    this.notifications,
    this.nextPageUrl,
    this.total,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      currentPage: json['current_page'],
      notifications: (json['data'] as List)
          .map((e) => NotificationItem.fromJson(e))
          .toList(),
      nextPageUrl: json['next_page_url'],
      total: json['total'],
    );
  }
}

class NotificationItem {
  int? id;
  String? title;
  String? body;
  int? senderId;

  int? mediaId;
  String? route;
  int? seen;
  DateTime? createdAt;
  Sender? sender;

  NotificationItem({
    this.id,
    this.title,
    this.body,
    this.route,
    this.mediaId,
    this.seen,
    this.createdAt,
    this.sender,
    this.senderId,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      senderId: json['sender_id'],
      mediaId: json['media_id'],
      route: json['route'],
      seen: json['seen'],
      createdAt: DateTime.parse(json['created_at']),
      sender: Sender.fromJson(json['sender']),
    );
  }

  NotificationItem copyWith({int? seen}) {
    return NotificationItem(
      id: id,
      title: title,
      body: body,
      route: route,
      seen: seen ?? this.seen,
      createdAt: createdAt,
      sender: sender,
    );
  }
}

class Sender {
  int? id;
  String? name;
  String? profileImage;

  Sender({this.id, this.name, this.profileImage});

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      name: json['name'],
      profileImage: json['profile_image'],
    );
  }
}
