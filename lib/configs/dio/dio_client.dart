import 'package:base_core/configs/dio/app_interceptor.dart';
import 'package:base_core/configs/system.dart';
import 'package:base_core/flavors.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioClient {
  DioClient(this.dio) {
    dio
      ..options.baseUrl = dotenv.get('BASE_URL')
      ..options.headers = SystemConfiguration.defaultJsonHeaders
      ..options.connectTimeout = const Duration(seconds: 60)
      ..options.receiveTimeout = const Duration(seconds: 60)
      ..options.responseType = ResponseType.json;
    _setInterceptorsByEnv(dio);
  }

  late Dio dio;

  void _setInterceptorsByEnv(Dio dio) {
    final flavor = dotenv.get('FLAVOR');
    if (flavor == Flavor.develop.name) {
      dio.interceptors.add(ChuckerDioInterceptor());
    } else if (flavor == Flavor.uat.name) {
      dio.interceptors.add(InterceptorsWrapper());
    } else if (flavor == Flavor.product.name) {}
    dio.interceptors.add(AppInterceptor());
  }
}
