import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BaseSecureStorage {
  BaseSecureStorage();

  FlutterSecureStorage get getStorageOption {
    return const FlutterSecureStorage();
  }

  Future<bool> containsKey({required String key}) async {
    return getStorageOption.containsKey(
      key: key,
    );
  }

  Future<void> removeValue({required String key}) async {
    return getStorageOption.delete(
      key: key,
    );
  }

  Future<void> removeAll() async {
    return getStorageOption.deleteAll();
  }

  Future<void> setValue({required String key, required String value}) async {
    return getStorageOption.write(
      key: key,
      value: value,
    );
  }

  Future<String?> getValue({required String key}) async {
    return getStorageOption.read(
      key: key,
    );
  }
}
