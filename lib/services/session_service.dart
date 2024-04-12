import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static final SessionService _instance = SessionService._internal();
  factory SessionService() => _instance;
  SessionService._internal();

  late SharedPreferences prefs;

  static const String userInfoSession = 'USER';

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  saveUserInfo(Map user) {
    prefs.setString(userInfoSession, json.encode(user));
  }

  Map<String, dynamic>? getUserInfoSession() {
    String? user = prefs.getString(userInfoSession);
    if (user != null) {
      return json.decode(user);
    }
    return null;
  }

  removeUserInfo() {
    prefs.remove(userInfoSession);
  }

  clearAll() {
    prefs.clear();
  }
}
