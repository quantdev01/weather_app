import 'dart:developer';

import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      //* decoding the json data from the string data to access longitude data
      return jsonDecode(data);
    } else {
      log('${response.statusCode}');
    }
  }
}
