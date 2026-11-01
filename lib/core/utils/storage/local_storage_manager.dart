import 'dart:convert';

import 'package:beu_codelab/core/utils/storage/storage_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageManager implements StorageManager {
  static late SharedPreferences _sharedPreferences;

  LocalStorageManager._();

  factory LocalStorageManager.getInstance(SharedPreferences sharedPreferences) {
    _sharedPreferences = sharedPreferences;
    return LocalStorageManager._();
  }

  @override
  Future<bool> putBool(String key, {required bool value}) =>
      _sharedPreferences.setBool(key, value);

  @override
  Future<bool?> getBool(String key, {bool? defaultValue}) async =>
      _sharedPreferences.containsKey(key)
          ? _sharedPreferences.getBool(key)
          : defaultValue;

  @override
  Future<bool> putDouble(String key, double value) =>
      _sharedPreferences.setDouble(key, value);

  @override
  Future<double?> getDouble(String key, {double? defaultValue}) async =>
      _sharedPreferences.containsKey(key)
          ? _sharedPreferences.getDouble(key)
          : defaultValue;

  @override
  Future<bool> putInt(String key, int value) =>
      _sharedPreferences.setInt(key, value);

  @override
  Future<int?> getInt(String key, {int? defaultValue}) async =>
      _sharedPreferences.containsKey(key)
          ? _sharedPreferences.getInt(key)
          : defaultValue;

  @override
  Future<bool> putString(String key, String value) =>
      _sharedPreferences.setString(key, value);

  @override
  Future<String?> getString(String key, {String? defaultValue}) async =>
      _sharedPreferences.containsKey(key)
          ? _sharedPreferences.getString(key)
          : defaultValue;

  @override
  Future<bool> putStringList(String key, List<String> value) =>
      _sharedPreferences.setStringList(key, value);

  @override
  Future<List<String>?> getStringList(String key) async =>
      _sharedPreferences.containsKey(key)
          ? _sharedPreferences.getStringList(key)
          : null;
  @override
  Future<Map<String, dynamic>?> getObjectMap(String key) async {
    if (!_sharedPreferences.containsKey(key)) return null;
    return jsonDecode(_sharedPreferences.getString(key) ?? "");
  }

  @override
  Future<bool> putObjectMp(String key, Map<String, dynamic>? value) =>
      _sharedPreferences.setString(key, jsonEncode(value));

  @override
  Future<bool> isKeyExists(String key) async =>
      _sharedPreferences.containsKey(key);

  @override
  Future<bool> clearKey(String key) => _sharedPreferences.remove(key);

  @override
  Future<bool> clearAll() => _sharedPreferences.clear();
}
