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

  Future authenticateWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    try {
      var result = await _googleSignIn.signIn();
      print(result!.displayName);
    } catch (error) {}
  }

  Future createNewUser(
      String username, String email, String phone, String password) async {
    Uri _BaseURL = Uri.parse('$baseUrl/users/');
    try {
      Map<String, dynamic> body = {
        'username': username,
        'email': email,
        'mobile': phone,
        'password': password
      };
      http.Response res = await http.post(_BaseURL, body: body);
      var decodedBody = jsonDecode(res.body);
      if (res.statusCode == 200 && decodedBody['success'] == 1) {
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
}
