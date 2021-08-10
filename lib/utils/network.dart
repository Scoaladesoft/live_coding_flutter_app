import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class NetworkUtils {
  static const String _url = 'scoaladesoft.ro';
  static const String _prePath = 'wp-json/wc/v2';

  static const String _username = 'ck_697d95c170e2104a516199432ebbc8aab28a892c';
  static const String _password = 'cs_08e081b87d0219ee306f07a912934a1dd4f8f643';

  static void wooRequest(String endpoint,
      {bool isPOST = false,
      required Function cb,
      Map<String, String> queryParams = const <String, String>{}}) async {
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode(_username + ':' + _password));

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      'authorization': basicAuth
    };

    var response;

    if (!isPOST) {
      final uri = Uri.https(_url, _prePath + endpoint, queryParams);

      response = await http.get(uri, headers: headers);
    }

    if (response.statusCode == 200) {
      var responseObject = convert.jsonDecode(response.body) as List<dynamic>;
      cb(responseObject);
    } else {
      throw Exception('There was a problem requesting the Woo Response');
    }
  }
}
