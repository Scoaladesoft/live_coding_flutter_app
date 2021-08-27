import 'billing.dart';
import 'lineItems.dart';
import 'shipping.dart';
import 'shippingLines.dart';

class OrderModel {
  late String paymentMethod;
  late String paymentMethodTitle;
  late bool setPaid;
  late Billing billing;
  late Shipping shipping;
  late List<LineItems> lineItems;
  late List<ShippingLines> shippingLines;

  OrderModel(
      {required this.paymentMethod,
      required this.paymentMethodTitle,
      required this.setPaid,
      required this.billing,
      required this.shipping,
      required this.lineItems,
      required this.shippingLines});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method'] = this.paymentMethod;
    data['payment_method_title'] = this.paymentMethodTitle;
    data['set_paid'] = this.setPaid;
    data['billing'] = this.billing.toJson();
    data['shipping'] = this.shipping.toJson();
    data['line_items'] = this.lineItems.map((v) => v.toJson()).toList();
    data['shipping_lines'] = this.shippingLines.map((v) => v.toJson()).toList();
    return data;
  }
}
