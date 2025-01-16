import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BaseSecureStorage {
  BaseSecureStorage() {
    _storageOption = FlutterSecureStorage(
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOption(),
      webOptions: _getWebOptions(),
    );
  }

  FlutterSecureStorage? _storageOption;

  FlutterSecureStorage get getStorageOption {
    return _storageOption ?? const FlutterSecureStorage();
  }

  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  IOSOptions _getIOSOption() => IOSOptions.defaultOptions;

  WebOptions _getWebOptions() => WebOptions.defaultOptions;

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
