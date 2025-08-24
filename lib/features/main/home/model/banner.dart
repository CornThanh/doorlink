class BannerModel {
  final int? id;
  final String? title;
  final String? description;
  final String? bannerButton;
  final String? url;
  final String? imageUrl;
  final String? status;
  final String? sortOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BannerModel({
    this.id,
    this.title,
    this.description,
    this.bannerButton,
    this.url,
    this.imageUrl,
    this.status,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      bannerButton: json['banner_button']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      imageUrl: json['image_url']?.toString() ?? '',
      status: json['status']?.toString() ?? 'active',
      sortOrder: json['sort_order']?.toString() ?? '1',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'banner_button': bannerButton,
      'url': url,
      'image_url': imageUrl,
      'status': status,
      'sort_order': sortOrder,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
