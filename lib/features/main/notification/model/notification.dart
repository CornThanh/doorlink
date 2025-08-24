class NotificationModel {
  final int? id;
  final String? title;
  final String? body;
  final String? type;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? data;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      title: json['title']?.toString() ??
          json['notification_title']?.toString() ??
          '',
      body: json['body']?.toString() ??
          json['notification_body']?.toString() ??
          json['message']?.toString() ??
          '',
      type: json['type']?.toString() ??
          json['notification_type']?.toString() ??
          'general',
      status: json['status']?.toString() ?? 'unread',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : json['timestamp'] != null
              ? DateTime.tryParse(json['timestamp'].toString())
              : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
      data:
          json['data'] != null ? Map<String, dynamic>.from(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'type': type,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'data': data,
    };
  }

  // Helper getters for backward compatibility with existing UI
  String get description => body ?? '';
  String get timeAgo {
    if (createdAt == null) return 'Unknown time';

    final now = DateTime.now();
    final difference = now.difference(createdAt!);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  String get iconUrl {
    // Default icon based on type or use a generic one
    switch (type?.toLowerCase()) {
      case 'offer':
      case 'promotion':
        return 'https://cdn-icons-png.flaticon.com/512/733/733544.png';
      case 'alert':
      case 'warning':
        return 'https://cdn-icons-png.flaticon.com/512/733/733544.png';
      case 'news':
      case 'update':
        return 'https://cdn-icons-png.flaticon.com/512/733/733544.png';
      default:
        return 'https://cdn-icons-png.flaticon.com/512/733/733544.png';
    }
  }
}
