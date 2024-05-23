import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  var url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
    } else
      print(response.statusCode);

    return jsonDecode(response.body);
  }
}
