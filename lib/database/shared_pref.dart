import 'package:shared_preferences/shared_preferences.dart';

class Sharedpref {
  static SharedPreferences? sharedpreference;

  static Future<void> initial() async {
    sharedpreference = await SharedPreferences.getInstance();
  }

  static Future<bool> storeData({
    required dynamic key,
    required dynamic value,
  }) async {
    if (sharedpreference == null) {
      await initial();
    }

    if (value is int) {
      return await sharedpreference!.setInt(key, value);
    } else if (value is double) {
      return await sharedpreference!.setDouble(key, value);
    } else if (value is String) {
      return await sharedpreference!.setString(key, value);
    } else if (value is bool) {
      return await sharedpreference!.setBool(key, value);
    } else {
      return await sharedpreference!.setStringList(key, value);
    }
  }

  static dynamic getData({required dynamic key}) async {
    if (sharedpreference == null) {
      await initial();
    }
    return sharedpreference!.get(key);
  }

  static Future<bool> removeData({required dynamic key}) async {
    if (sharedpreference == null) {
      await initial();
    }
    return await sharedpreference!.remove(key);
  }

  static Future<bool> clearData() async {
    if (sharedpreference == null) {
      await initial();
    }
    return await sharedpreference!.clear();
  }

  static Future<bool> containkey({required dynamic key}) async {
    if (sharedpreference == null) {
      await initial();
    }
    return sharedpreference!.containsKey(key);
  }
}
