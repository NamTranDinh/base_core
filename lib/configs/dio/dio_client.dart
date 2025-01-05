import 'package:base_core/configs/dio/app_interceptor.dart';
import 'package:base_core/configs/system.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  DioClient(this.dio) {
    dio
      ..options.baseUrl = dotenv.get('BASE_URL')
      ..options.headers = SystemConfiguration.header
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..options.responseType = ResponseType.json;
    _setInterceptorsByEnv(dio);
  }

  late Dio dio;

  void _setInterceptorsByEnv(Dio dio) {
    if (kReleaseMode) {
      switch (dotenv.get('FLAVOR')) {
        case 'PRODUCT':
          dio.interceptors.add(AppInterceptor());
        case 'DEVELOPMENT':
          dio.interceptors.add(ChuckerDioInterceptor());
        default:
          dio.interceptors.add(AppInterceptor());
      }
    } else {
      dio.interceptors.add(ChuckerDioInterceptor());
      dio.interceptors.add(AppInterceptor());
    }
  }
}
