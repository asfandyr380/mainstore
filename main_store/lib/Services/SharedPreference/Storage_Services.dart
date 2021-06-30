import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  Future saveUser(String email) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('user', email);
  }

  Future getUser() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('user') != null;
  }

  Future deleteUser() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove('user');
  }
}
