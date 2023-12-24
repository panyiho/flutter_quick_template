import 'package:shared_preferences/shared_preferences.dart';
import 'light_storage.dart';

class SharePreferenceStorage extends AbsLightStorage {
  late SharedPreferences _preferences;
  @override
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  @override
  bool getBoolean(String key, {bool defaultValue = false}) {
    return _preferences.getBool(key) ?? defaultValue;
  }

  @override
  double getDouble(String key, {double defaultValue = 0}) {
    return _preferences.getDouble(key) ?? defaultValue;
  }

  @override
  int getInt(String key, {int defaultValue = 0}) {
    return _preferences.getInt(key) ?? defaultValue;
  }

  @override
  String getString(String key, {String defaultValue = ""}) {
    return _preferences.getString(key) ?? defaultValue;
  }

  @override
  Future<void> putBoolean(String key, bool value) {
    return _preferences.setBool(key, value);
  }

  @override
  Future<void> putDouble(String key, double value) {
    return _preferences.setDouble(key, value);
  }

  @override
  Future<void> putInt(String key, int value) {
    return _preferences.setInt(key, value);
  }

  @override
  Future<void> putString(String key, String value) {
    return _preferences.setString(key, value);
  }

  @override
  Future<void> remove(String key) {
    return _preferences.remove(key);
  }

  @override
  Future<void> clear() {
    return _preferences.clear();
  }

  @override
  bool containsKey(String key) {
    return _preferences.containsKey(key);
  }
}
