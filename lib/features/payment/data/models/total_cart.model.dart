class TotalCart {
  final double totalPrice;
  final double totalOriginalPrice;
  final double shippingFee;
  final double totalDiscountValue;
  final int quantity;
  bool isCaculating = false;
  final String? note;

  TotalCart({
    required this.totalPrice,
    required this.totalOriginalPrice,
    required this.shippingFee,
    required this.totalDiscountValue,
    required this.quantity,
    this.note,
  });

  double get finalPrice => totalPrice + shippingFee;

  @override
  String toString() {
    return 'TotalCart(totalPrice: $totalPrice, totalOriginalPrice: $totalOriginalPrice, shippingFee: $shippingFee, totalDiscountValue: $totalDiscountValue, quantity: $quantity, note: $note, isCaculating: $isCaculating)';
  }
}
