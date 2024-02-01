import 'package:get_storage/get_storage.dart';

class TLocaleStorage {
  late final GetStorage _storage;
  static TLocaleStorage? _instance;

  TLocaleStorage._internal();

  factory TLocaleStorage.instance() {
    _instance ??= TLocaleStorage._internal();
    return _instance!;
  }

// initializing a new bucket
  static Future<void> initStorage(String bucketName) async {
    await GetStorage.init(bucketName);

    _instance = TLocaleStorage._internal();
    _instance!._storage = GetStorage(bucketName);
    print('initialized successfully');
  }

  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  Future<void> removeData<T>(String key) async {
    await _storage.remove(key);
  }

  Future<void> clearAllData() async {
    await _storage.erase();
  }
}
