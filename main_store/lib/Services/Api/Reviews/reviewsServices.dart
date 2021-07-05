import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Models/ReviewModel.dart';

class ReviewServices {
  Future getReviews() async {
    Uri url = Uri.parse('$baseUrl/reviews');
    http.Response res = await http.get(url);
    List decodedBody = jsonDecode(res.body);
    if (res.statusCode == 200) {
      return decodedBody.map((e) => ReviewModel.fromJson(e)).toList();
    }
  }
}
