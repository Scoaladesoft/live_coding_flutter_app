import 'package:flutter/material.dart';
import 'package:scoaladesoft/screens/productScreen.dart';
import 'package:scoaladesoft/utils/html.dart';
import 'package:scoaladesoft/utils/network.dart';

class ProductByCategoryScreen extends StatefulWidget {
  int categoryID;
  String categoryName;

  ProductByCategoryScreen(
      {Key? key, required this.categoryID, required this.categoryName})
      : super(key: key);

  @override
  _ProductByCategoryScreenState createState() =>
      _ProductByCategoryScreenState();
}

class _ProductByCategoryScreenState extends State<ProductByCategoryScreen> {
  List<dynamic> wooProducts = [];
  bool loaded = false;

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
      loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryName),
        ),
        body: loaded
            ? (wooProducts.length > 0
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            key: const PageStorageKey<String>('list1'),
                            itemCount: wooProducts.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductScreen(
                                              title: wooProducts[index]['name'],
                                              featuredImageURL:
                                                  wooProducts[index]['images']
                                                      [0]['src'],
                                              description: wooProducts[index]
                                                  ['description'])));
                                },
                                child: Card(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.network(
                                          wooProducts[index]['images'][0]
                                              ['src'],
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
                                              wooProducts[index][
                                                              'short_description']
                                                          .length >
                                                      0
                                                  ? HtmlUtils.removeAllHtmlTags(
                                                      wooProducts[index]
                                                          ['short_description'])
                                                  : HtmlUtils.removeAllHtmlTags(
                                                      wooProducts[index]
                                                          ['description']),
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
                  )
                : Center(
                    child:
                        Text('In aceasta categorie nu au fost gasite produse.'),
                  ))
            : Center(child: CircularProgressIndicator()));
  }
}
