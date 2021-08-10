import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            Text(removeAllHtmlTags(this.description)),
            TextButton(
              onPressed: () {},
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

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }
}
