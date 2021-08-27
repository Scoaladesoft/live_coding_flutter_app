class ShippingLines {
  late String methodId;
  late String methodTitle;
  late String total;

  ShippingLines(
      {required this.methodId, required this.methodTitle, required this.total});

  ShippingLines.fromJson(Map<String, dynamic> json) {
    methodId = json['method_id'];
    methodTitle = json['method_title'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method_id'] = this.methodId;
    data['method_title'] = this.methodTitle;
    data['total'] = this.total;
    return data;
  }
}
