// import 'package:mmkv/mmkv.dart';
// import 'light_storage.dart';

// class MMKVStorage extends AbsLightStorage {
//   late MMKV _mmkv;
//   @override
//   Future<void> clear() async {
//     _mmkv.clearAll();
//   }

//   @override
//   bool getBoolean(String key, {bool defaultValue = false}) {
//     return _mmkv.decodeBool(key, defaultValue: defaultValue);
//   }

//   @override
//   double getDouble(String key, {double defaultValue = 0}) {
//     return _mmkv.decodeDouble(key, defaultValue: defaultValue);
//   }

//   @override
//   int getInt(String key, {int defaultValue = 0}) {
//     return _mmkv.decodeInt(key, defaultValue: defaultValue);
//   }

//   @override
//   String getString(String key, {String defaultValue = ""}) {
//     return _mmkv.decodeString(key) ?? defaultValue;
//   }

//   @override
//   Future<void> init() async {
//     await MMKV.initialize();
//     _mmkv = MMKV.defaultMMKV();
//   }

//   @override
//   Future<void> putBoolean(String key, bool value) async {
//     _mmkv.encodeBool(key, value);
//   }

//   @override
//   Future<void> putDouble(String key, double value) async {
//     _mmkv.encodeDouble(key, value);
//   }

//   @override
//   Future<void> putInt(String key, int value) async {
//     _mmkv.encodeInt(key, value);
//   }

//   @override
//   Future<void> putString(String key, String value) async {
//     _mmkv.encodeString(key, value);
//   }

//   @override
//   Future<void> remove(String key) async {
//     _mmkv.removeValue(key);
//   }

//   @override
//   bool containsKey(String key) {
//     return _mmkv.containsKey(key);
//   }
// }
