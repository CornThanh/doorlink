class Mail {
  final int? id;
  final String fromMail;
  final String toMail;
  final String subject;
  final String description;
  final String status;
  final String type;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Mail({
    this.id,
    required this.fromMail,
    required this.toMail,
    required this.subject,
    required this.description,
    required this.status,
    required this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory Mail.fromJson(Map<String, dynamic> json) {
    return Mail(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      fromMail: json['from_mail']?.toString() ?? '',
      toMail: json['to_mail']?.toString() ?? '',
      subject: json['subject']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
    );
  }

  // Helper getters for backward compatibility
  String get sender => fromMail.split('@').first;
  String get senderEmail => fromMail;
  String get snippet => description.length > 50
      ? '${description.substring(0, 50)}...'
      : description;
  String get time {
    if (createdAt == null) return 'Unknown';
    final now = DateTime.now();
    final difference = now.difference(createdAt!);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  bool get isRead => status.toLowerCase() == 'read';
}
