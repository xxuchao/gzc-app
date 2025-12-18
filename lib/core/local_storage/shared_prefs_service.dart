// 普通存储实现
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';
import 'storage_service.dart';

@Singleton(as: LocalStorageService)
class SharedPrefsService implements LocalStorageService {
  final SharedPreferences _prefs;
  SharedPrefsService._(this._prefs);

  @factoryMethod
  static Future<SharedPrefsService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefsService._(prefs);
  }
  
  @override
  Future<void> setString(String key, String value) => _prefs.setString(key, value);
  @override
  Future<String?> getString(String key) async => _prefs.getString(key);
  @override
  Future<void> setBool(String key, bool value) => _prefs.setBool(key, value);
  @override
  Future<bool?> getBool(String key) async => _prefs.getBool(key);
  @override
  Future<void> setInt(String key, int value) => _prefs.setInt(key, value);
  @override
  Future<int?> getInt(String key) async => _prefs.getInt(key);
  @override
  Future<void> remove(String key) => _prefs.remove(key);
  @override
  Future<void> clear() => _prefs.clear();
}