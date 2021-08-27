import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoaladesoft/utils/html.dart';
import 'package:http/http.dart' as http;

import 'package:scoaladesoft/woocommerce/billing.dart';
import 'package:scoaladesoft/woocommerce/lineItems.dart';
import 'package:scoaladesoft/woocommerce/orderModel.dart';
import 'package:scoaladesoft/woocommerce/shipping.dart';
import 'package:scoaladesoft/woocommerce/shippingLines.dart';

class ProductScreen extends StatelessWidget {
  String title;
  String featuredImageURL;
  String description = '';

  ProductScreen(
      {Key? key,
      required this.title,
      required this.featuredImageURL,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Image(image: NetworkImage(this.featuredImageURL)),
            Text(
              this.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(HtmlUtils.removeAllHtmlTags(this.description)),
            TextButton(
              onPressed: () {
                print('comanda');
                placeOrder();
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Comanda',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
  }

  void placeOrder() {
    List<ShippingLines> shippingLines = <ShippingLines>[
      ShippingLines(
        methodId: 'flat_rate',
        methodTitle: 'Flat Rate',
        total: '10.0',
      )
    ];

    List<LineItems> lineItems = <LineItems>[
      LineItems(productId: 31, quantity: 1)
    ];

    Shipping shipping = Shipping(
        firstName: 'Alex',
        lastName: 'Bordei',
        country: "RO",
        city: "Bucharest",
        address1: "Strada Strazilor, nr 113");

    Billing billing = Billing(
        country: "RO",
        firstName: "Alex",
        lastName: "Bordei",
        email: "alex.bordei1991@gmail.com",
        phone: "0711223344",
        city: "Bucharest",
        address1: "Strada Strazilor, nr. 93");

    OrderModel orderRequest = OrderModel(
      lineItems: lineItems,
      paymentMethod: "bacs",
      shippingLines: shippingLines,
      shipping: shipping,
      paymentMethodTitle: 'Direct Bank Transfer',
      setPaid: true,
      billing: billing,
    );

    makeRequest(orderRequest);
  }

  void makeRequest(OrderModel orderRequest) async {
    const String _username = 'ck_73d54f89606960bce5dd2a5005ee8057c73b75e4';
    const String _password = 'cs_b565c672b0658ab920b09571c323c7757751e620';

    String basicAuth =
        'Basic ' + base64Encode(utf8.encode(_username + ':' + _password));

    final response = await http.post(
        Uri.parse('https://scoaladesoft.ro/wp-json/wc/v3/orders'),
        headers: <String, String>{
          'Authorization': basicAuth,
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(orderRequest.toJson()));

    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.body);
    }
  }
}
