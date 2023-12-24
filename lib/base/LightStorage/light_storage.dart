// import 'mmkv_light_storage.dart';
import 'shared_preference_light_storage.dart';

abstract class AbsLightStorage {
  Future<void> init();
  Future<void> putInt(String key, int value);
  Future<void> putBoolean(String key, bool value);
  Future<void> putDouble(String key, double value);
  Future<void> putString(String key, String value);

  int getInt(String key, {int defaultValue = 0});
  bool getBoolean(String key, {bool defaultValue = false});
  double getDouble(String key, {double defaultValue = 0});
  String getString(String key, {String defaultValue = ""});

  bool containsKey(String key);

  Future<void> remove(String key);
  Future<void> clear();
}

class LightStorage extends AbsLightStorage {
  late AbsLightStorage poxyStorage;

  LightStorage._({required this.poxyStorage});

  static LightStorage? _instance;

  static LightStorage getInstance() {
    //目前有2种实现
    // _instance ??= LightStorage._(poxyStorage: MMKVStorage());
    _instance ??= LightStorage._(poxyStorage: SharePreferenceStorage());
    return _instance!;
  }

  @override
  Future<void> clear() {
    return poxyStorage.clear();
  }

  @override
  bool getBoolean(String key, {bool defaultValue = false}) {
    return poxyStorage.getBoolean(key, defaultValue: defaultValue);
  }

  @override
  double getDouble(String key, {double defaultValue = 0}) {
    return poxyStorage.getDouble(key, defaultValue: defaultValue);
  }

  @override
  int getInt(String key, {int defaultValue = 0}) {
    return poxyStorage.getInt(key, defaultValue: defaultValue);
  }

  @override
  String getString(String key, {String defaultValue = ""}) {
    return poxyStorage.getString(key, defaultValue: defaultValue);
  }

  @override
  Future<void> init() async {
    return poxyStorage.init();
  }

  @override
  Future<void> putBoolean(String key, bool value) {
    return poxyStorage.putBoolean(key, value);
  }

  @override
  Future<void> putDouble(String key, double value) {
    return poxyStorage.putDouble(key, value);
  }

  @override
  Future<void> putInt(String key, int value) {
    return poxyStorage.putInt(key, value);
  }

  @override
  Future<void> putString(String key, String value) {
    return poxyStorage.putString(key, value);
  }

  @override
  Future<void> remove(String key) {
    return poxyStorage.remove(key);
  }

  @override
  bool containsKey(String key) {
    return poxyStorage.containsKey(key);
  }
}
