class Coupon {
  final String code;              // Mã coupon, ví dụ: 'GIAM50'
  final String title;             // Tên hoặc tiêu đề, ví dụ: 'Giảm 50k cho đơn trên 300k'
  final String description;       // Mô tả chi tiết
  final double discountAmount;    // Mức giảm cố định, ví dụ: 50.0 (nếu là giảm tiền mặt)
  final double discountPercent;   // Mức giảm theo %, ví dụ: 10.0
  final double minimumOrderValue; // Điều kiện áp dụng, ví dụ: đơn hàng tối thiểu 300k
  final DateTime expiryDate;      // Thời gian hết hạn
  final bool isActive;            // Coupon còn hoạt động hay không
  final String iconUrl;           // URL icon hoặc hình ảnh minh hoạ (tuỳ chọn)

  Coupon({
    required this.code,
    required this.title,
    required this.description,
    required this.discountAmount,
    required this.discountPercent,
    required this.minimumOrderValue,
    required this.expiryDate,
    required this.isActive,
    required this.iconUrl,
  });

  // Optional: Method to check if coupon is expired
  bool get isExpired => DateTime.now().isAfter(expiryDate);

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