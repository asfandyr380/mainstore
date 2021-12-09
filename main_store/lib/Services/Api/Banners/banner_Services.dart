import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Models/Banners.dart';
import 'package:main_store/Models/BrandsModel.dart';
import 'package:main_store/Models/swipeBanner.dart';

class BannerServices {
  Future getBanner() async {
    Uri _BaseURL = Uri.parse('$baseUrl/banners/');
    try {
      http.Response res = await http.get(_BaseURL);
      var decodedBody = jsonDecode(res.body);
      if (res.statusCode == 200 && decodedBody['success'] == 1) {
        List data = decodedBody['data'];
        return data.map((e) => Banners.fromMap(e));
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  Future getBrands() async {
    Uri _BaseURL = Uri.parse('$baseUrl/stores/');
    try {
      http.Response res = await http.get(_BaseURL);
      var decodedBody = jsonDecode(res.body);
      if (res.statusCode == 200 && decodedBody['success'] == 1) {
        List data = decodedBody['data'];
        return data.map((e) => BrandsModel.fromMap(e)).toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  Future fetchSwipeBanners() async {
    Uri _BaseURL = Uri.parse('$baseUrl/swipeBanners/');

    try {
      http.Response res = await http.get(_BaseURL);
      var decodedBody = jsonDecode(res.body);
      if (res.statusCode == 200 && decodedBody['success'] == 1) {
        List data = decodedBody['data'];
        return data.map((e) => Swipebanner.fromMap(e)).toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }
}
