import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:main_store/Config/consts.dart';
import 'package:main_store/Config/locator.dart';
import 'package:main_store/Models/User_Model.dart';
import 'package:main_store/Services/SharedPreference/Storage_Services.dart';

class AuthServicesApi {
  StorageServices _services = locator<StorageServices>();
  static final _googleSignIn = GoogleSignIn();

  Future googleLogin() async {
    return await _googleSignIn.signIn();
  }

  Future loginWithGoogle(String email) async {
    Uri _LOGINURL = Uri.parse('$baseUrl/users/loginWithGoogle');
    try {
      UserModel user = UserModel(email: email);
      Map<String, dynamic> jsonBody = user.toJson();
      http.Response res = await http.post(_LOGINURL, body: jsonBody);
      var decodedBody = jsonDecode(res.body);
      if (res.statusCode == 200 && decodedBody['success'] == 1) {
        Map<String, dynamic> data = decodedBody['data'];
        var user = UserModel.fromJson(data);
        await _services.saveUser(user.email!, user.id!);
        return true;
      } else
        return decodedBody['message'];
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  Future createNewUser(String username, String email, String phone,
      String password, String address, String city, String postalCode) async {
    Uri _BaseURL = Uri.parse('$baseUrl/users/');
    try {
      Map<String, dynamic> body = {
        'username': username,
        'email': email,
        'mobile': phone,
        'password': password,
        'address': address,
        "city": city,
        "postal_code": postalCode
      };
      http.Response res = await http.post(_BaseURL, body: body);
      var decodedBody = jsonDecode(res.body);
      if (res.statusCode == 200 && decodedBody['success'] == 1) {
        int code = decodedBody['code'];
        await _services.saveCode(code.toString());
        await _services.saveUser(email, decodedBody['data']['insertId']);
        return true;
      } else {
        return decodedBody['message'];
      }
    } catch (e) {
      if (e is PlatformException) {
        print(e.message);
      } else {
        print(e);
      }
    }
  }

  Future getUserbyId(int id) async {
    Uri _UrlbyId = Uri.parse('$baseUrl/users/$id');
    try {
      http.Response res = await http.get(_UrlbyId);
      var body = jsonDecode(res.body);
      if (res.statusCode == 200 && body['success'] == 1) {
        Map<String, dynamic> map = body['data'];
        var user = UserModel.fromJson(map);
        return user;
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  Future logIn(String? email, String? password) async {
    Uri _LOGINURL = Uri.parse('$baseUrl/users/login');
    try {
      UserModel user = UserModel(email: email, password: password);
      Map<String, dynamic> jsonBody = user.toJson();
      http.Response res = await http.post(_LOGINURL, body: jsonBody);
      var decodedBody = jsonDecode(res.body);
      if (res.statusCode == 200 && decodedBody['success'] == 1) {
        Map<String, dynamic> data = decodedBody['data'];
        var user = UserModel.fromJson(data);
        await _services.saveUser(user.email!, user.id!);
        return true;
      } else
        return decodedBody['message'];
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  Future forgotPassword(String email, Map map) async {
    Uri _url;
    int result = await getUserByEmail(email);
    print("UserID ==> $result");
    if (result != 0) {
      _url = Uri.parse('$baseUrl/users/forgotPass/$result');
    } else
      return 0;
    try {
      http.Response res = await http.post(_url, body: map);
      var body = jsonDecode(res.body);
      print("Body ==> $body");
      if (res.statusCode == 200 && body['success'] == 1) {
        return 1;
      } else
        return 0;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  Future getUserByEmail(String email) async {
    Uri _url = Uri.parse('$baseUrl/users/getUser');
    try {
      var map = {"email": email};
      http.Response res = await http.post(_url, body: map);
      var body = jsonDecode(res.body);
      if (res.statusCode == 200 && body['success'] == 1) {
        var data = body['data'];
        return data['id'];
      } else
        return 0;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }

  verifyAccount(int id) async {
    Uri _url = Uri.parse('$baseUrl/users/verify/$id');
    try {
      http.Response res = await http.put(_url);
      var body = jsonDecode(res.body);
      if (res.statusCode == 200 && body['success'] == 1) {
        return 1;
      } else
        return 0;
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      } else {
        return e;
      }
    }
  }
}
