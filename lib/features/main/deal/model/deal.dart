class Deal {
  final String title;
  final String description;
  final String imageUrl;
  final DateTime createdDate;
  final DateTime expireDate;
  final String? summary;
  final String? content;
  final String? thumbnail;
  final String? isActive;
  final DateTime? publishedAt;
  final int? id;

  Deal({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdDate,
    required this.expireDate,
    this.summary,
    this.content,
    this.thumbnail,
    this.isActive,
    this.publishedAt,
    this.id,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    // Extract only the fields we need, ignore extra fields
    return Deal(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      title: json['title']?.toString() ?? json['name']?.toString() ?? '',
      summary: json['summary']?.toString() ?? json['subtitle']?.toString(),
      content: json['content']?.toString() ?? json['body']?.toString(),
      thumbnail: json['thumbnail']?.toString() ??
          json['image']?.toString() ??
          json['image_url']?.toString(),
      isActive: json['is_active']?.toString() ?? json['active']?.toString(),
      publishedAt: json['published_at'] != null
          ? DateTime.tryParse(json['published_at'].toString())
          : json['created_at'] != null
              ? DateTime.tryParse(json['created_at'].toString())
              : null,
      // Fallback fields for backward compatibility
      description: json['summary']?.toString() ??
          json['description']?.toString() ??
          json['subtitle']?.toString() ??
          '',
      imageUrl: json['thumbnail']?.toString() ??
          json['image']?.toString() ??
          json['image_url']?.toString() ??
          '',
      createdDate: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString()) ?? DateTime.now()
          : json['published_at'] != null
              ? DateTime.tryParse(json['published_at'].toString()) ??
                  DateTime.now()
              : DateTime.now(),
      expireDate: json['expires_at'] != null
          ? DateTime.tryParse(json['expires_at'].toString()) ??
              DateTime.now().add(const Duration(days: 30))
          : json['end_date'] != null
              ? DateTime.tryParse(json['end_date'].toString()) ??
                  DateTime.now().add(const Duration(days: 30))
              : DateTime.now().add(const Duration(days: 30)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'summary': summary,
      'content': content,
      'thumbnail': thumbnail,
      'is_active': isActive,
      'published_at': publishedAt?.toIso8601String(),
      'description': description,
      'image_url': imageUrl,
      'created_at': createdDate.toIso8601String(),
      'expires_at': expireDate.toIso8601String(),
    };
  }
}
