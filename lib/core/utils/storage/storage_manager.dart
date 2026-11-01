abstract interface class StorageManager {
  StorageManager._();

  Future<bool> putBool(String key, {required bool value});

  Future<bool?> getBool(String key, {bool? defaultValue});

  Future<bool> putDouble(String key, double value);

  Future<double?> getDouble(String key, {double? defaultValue});

  Future<bool> putInt(String key, int value);

  Future<int?> getInt(String key, {int? defaultValue});

  Future<bool> putString(String key, String value);

  Future<String?> getString(String key, {String? defaultValue});
  Future<bool> putStringList(String key, List<String> value);

  Future<List<String>?> getStringList(String key);
  Future<Map<String, dynamic>?> getObjectMap(String key);

  Future<bool> putObjectMp(String key, Map<String, dynamic>? value);

  Future<bool> isKeyExists(String key);

  Future<bool> clearKey(String key);

  Future<bool> clearAll();
}
