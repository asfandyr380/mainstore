import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:main_store/Config/consts.dart';

class MessageServices {
  Future sendMessage(Map body) async {
    Uri url = Uri.parse('$baseUrl/message');
    http.Response res = await http.post(url, body: body);
    var decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200 && decodedBody['success'] == 1) {
      return 1;
    } else
      return 0;
  }
}
