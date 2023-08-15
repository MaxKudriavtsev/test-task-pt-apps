import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  void setString(String key, String value) {
    _preferences.setString(key, value);
  }

  String? getString(String key) {
    return _preferences.getString(key);
  }

  void setBool(String key, bool value) {
    _preferences.setBool(key, value);
  }

  bool? getBool(String key) {
    return _preferences.getBool(key);
  }
}
