import 'dart:convert';

class NotificationsModel {
    final int? id;
    final int? userId;
    final String? type;
    final String? subject;
    final String? body;
    final String? icon;
    final dynamic action;
    final dynamic url;
    final DateTime? sentAt;
    final dynamic readAt;
    final dynamic deletedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    NotificationsModel({
        this.id,
        this.userId,
        this.type,
        this.subject,
        this.body,
        this.icon,
        this.action,
        this.url,
        this.sentAt,
        this.readAt,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory NotificationsModel.fromRawJson(String str) => NotificationsModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
        id: json["id"],
        userId: json["user_id"],
        type: json["type"],
        subject: json["subject"],
        body: json["body"],
        icon: json["icon"],
        action: json["action"],
        url: json["url"],
        sentAt: json["sent_at"] == null ? null : DateTime.parse(json["sent_at"]),
        readAt: json["read_at"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type": type,
        "subject": subject,
        "body": body,
        "icon": icon,
        "action": action,
        "url": url,
        "sent_at": sentAt?.toIso8601String(),
        "read_at": readAt,
        "deleted_at": deletedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
