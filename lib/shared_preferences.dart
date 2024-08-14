import 'package:shared_preferences/shared_preferences.dart';

void saveLoginState(state) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('isLogin', state);
}

void saveUserDetails(firstName, email) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('firstName', firstName);
  prefs.setString('email', email);
}

Future<String?> getUserName() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('firstName');
  return token;
}

Future<String?> getEmail() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('email');
  return token;
}

Future<bool?> loginCheck() async {
  final prefs = await SharedPreferences.getInstance();
  bool? loginSave = prefs.getBool('isLogin');
  return loginSave;
}