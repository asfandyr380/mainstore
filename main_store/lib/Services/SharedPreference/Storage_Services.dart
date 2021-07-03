import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  Future saveUser(String email, int userId) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setString('user', email);
    _preferences.setInt('id', userId);
  }

  Future getUser() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.getString('user') != null;
  }

  Future getUserId() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    return _preferences.get('id');
  }

  Future deleteUser() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove('user');
    _preferences.remove('id');
  }
}
