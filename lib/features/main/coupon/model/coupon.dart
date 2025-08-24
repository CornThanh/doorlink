class Coupon {
  final int? id;
  final String couponName;
  final String description;
  final int type;
  final double discount;
  final DateTime? expireAt;
  final int status;
  final int couponLimit;
  final int couponLimitLeft;
  final String? couponUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Coupon({
    this.id,
    required this.couponName,
    required this.description,
    required this.type,
    required this.discount,
    this.expireAt,
    required this.status,
    required this.couponLimit,
    required this.couponLimitLeft,
    this.couponUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) {
    return Coupon(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      couponName: json['coupon_name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      type:
          json['type'] != null ? int.tryParse(json['type'].toString()) ?? 0 : 0,
      discount: json['discount'] != null
          ? double.tryParse(json['discount'].toString()) ?? 0.0
          : 0.0,
      expireAt: json['expire_at'] != null
          ? DateTime.tryParse(json['expire_at'].toString())
          : null,
      status: json['status'] != null
          ? int.tryParse(json['status'].toString()) ?? 0
          : 0,
      couponLimit: json['coupon_limit'] != null
          ? int.tryParse(json['coupon_limit'].toString()) ?? 0
          : 0,
      couponLimitLeft: json['coupon_limit_left'] != null
          ? int.tryParse(json['coupon_limit_left'].toString()) ?? 0
          : 0,
      couponUrl: json['coupon_url']?.toString(),
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
      'coupon_name': couponName,
      'description': description,
      'type': type,
      'discount': discount,
      'expire_at': expireAt?.toIso8601String(),
      'status': status,
      'coupon_limit': couponLimit,
      'coupon_limit_left': couponLimitLeft,
      'coupon_url': couponUrl,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  // Helper getters for backward compatibility
  String get title => couponName;
  String get code => couponName;
  String get iconUrl =>
      'https://picsum.photos/id/1016/800/400'; // Default image
  double get discountAmount => type == 1 ? discount : 0.0; // Fixed amount
  double get discountPercent => type == 2 ? discount : 0.0; // Percentage
  double get minimumOrderValue => 0.0; // Default value
  bool get isActive => status == 1;
  DateTime get expiryDate =>
      expireAt ?? DateTime.now().add(const Duration(days: 30));

  // Optional: Method to check if coupon is expired
  bool get isExpired => expireAt != null && DateTime.now().isAfter(expireAt!);

  // Optional: Apply coupon logic (example use case)
  double applyDiscount(double totalPrice) {
    if (totalPrice < minimumOrderValue) return totalPrice;

    if (discountPercent > 0) {
      return totalPrice * (1 - discountPercent / 100);
    } else {
      return totalPrice - discountAmount;
    }
  }
}
