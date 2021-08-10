import 'package:flutter/material.dart';
import 'package:scoaladesoft/utils/html.dart';
import 'package:scoaladesoft/utils/network.dart';

class ProductByCategoryScreen extends StatefulWidget {
  int categoryID;

  ProductByCategoryScreen({Key? key, required this.categoryID})
      : super(key: key);

  @override
  _ProductByCategoryScreenState createState() =>
      _ProductByCategoryScreenState();
}

class _ProductByCategoryScreenState extends State<ProductByCategoryScreen> {
  List<dynamic> wooProducts = [];

  @override
  void initState() {
    super.initState();
    Map<String, String> params = {'category': widget.categoryID.toString()};
    NetworkUtils.wooRequest('/products',
        cb: processResponse, queryParams: params);
  }

  void processResponse(List<dynamic> object) {
    setState(() {
      wooProducts = object;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            SizedBox(height: 70),
            Text(
              'Produse',
              style: TextStyle(fontSize: 36),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: wooProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(wooProducts[index]['images'][0]['src'],
                              width: 100),
                          Column(
                            children: [
                              Container(
                                width: 200,
                                child: Text(
                                  wooProducts[index]['name'],
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                width: 200,
                                child: Text(
                                  wooProducts[index]['short_description']
                                              .length >
                                          0
                                      ? HtmlUtils.removeAllHtmlTags(
                                          wooProducts[index]
                                              ['short_description'])
                                      : HtmlUtils.removeAllHtmlTags(
                                          wooProducts[index]['description']),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_forward),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
