import 'package:base_core/configs/dio/app_interceptor.dart';
import 'package:base_core/configs/system.dart';
import 'package:dio/dio.dart';

class DioFile {
  DioFile(this.dio) {
    dio
      ..options.headers = SystemConfiguration.header
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..options.responseType = ResponseType.json;
    _setInterceptorsByEnv(dio);
  }

  late Dio dio;

  void _setInterceptorsByEnv(Dio dio) {
    dio.interceptors.add(AppInterceptor());
  }
}
