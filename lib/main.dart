import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:scoaladesoft/screens/categoriesScreen.dart';
import 'package:scoaladesoft/utils/html.dart';
import 'package:scoaladesoft/utils/network.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scoala de Soft',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(body: CategoriesScreen()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic> wooProducts = [];

  @override
  void initState() {
    super.initState();
    NetworkUtils.wooRequest('/products', cb: processResponse);
  }

  void processResponse(List<dynamic> object) {
    setState(() {
      wooProducts = object;
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
              itemCount: wooProducts.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
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
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              wooProducts[index]['short_description'].length > 0
                                  ? HtmlUtils.removeAllHtmlTags(
                                      wooProducts[index]['short_description'])
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
                );
              },
            ),
          ),
          // wooProducts.length == 10
          //     ? Text('Nu sunt postari incarcate inca')
          //     : ListView.builder(
          //   itemCount: wooProducts.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Card(
          //       child: Padding(
          //         padding: const EdgeInsets.all(30.0),
          //         child: GestureDetector(
          //           onTap: () {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => ProductScreen(
          //                     title: wooProducts[index]['name'],
          //                     featuredImageURL: wooProducts[index]
          //                     ['images'][0]['src'],
          //                     description: wooProducts[index]
          //                     ['description'],
          //                   )),
          //             );
          //           },
          //           child: Text(
          //             wooProducts[index]['name'],
          //           ),
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
