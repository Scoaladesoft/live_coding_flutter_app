import 'package:flutter/material.dart';
import 'package:scoaladesoft/screens/productByCategoryScreen.dart';
import 'package:scoaladesoft/utils/html.dart';
import 'package:scoaladesoft/utils/network.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<dynamic> wooCategories = [];

  @override
  void initState() {
    super.initState();
    NetworkUtils.wooRequest('/products/categories', cb: processResponse);
  }

  void processResponse(List<dynamic> object) {
    setState(() {
      wooCategories = object;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          SizedBox(height: 70),
          Text(
            'Categorii',
            style: TextStyle(fontSize: 36),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: wooCategories.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductByCategoryScreen(
                              categoryID: wooCategories[index]['id'])),
                    );
                  },
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        wooCategories[index]['image'] != null
                            ? Image.network(
                                wooCategories[index]['image']['src'],
                                width: 100)
                            : Image.network(
                                'https://scoaladesoft.ro/wp-content/uploads/woocommerce-placeholder-324x324.png',
                                width: 100),
                        // Image.network(wooCategories[index]['images'][0]['src'],
                        //     width: 100),
                        Column(
                          children: [
                            Container(
                              width: 200,
                              child: Text(
                                wooCategories[index]['name'],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                wooCategories[index]['description'].length > 0
                                    ? HtmlUtils.removeAllHtmlTags(
                                        wooCategories[index]['description'])
                                    : '',
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
    );
  }
}
