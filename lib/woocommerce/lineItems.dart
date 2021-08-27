class LineItems {
  late int productId;
  late int quantity;
  late int variationId;

  LineItems(
      {required this.productId, required this.quantity, this.variationId = 0});

  LineItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
    variationId = json['variation_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['variation_id'] = this.variationId;
    return data;
  }
}
