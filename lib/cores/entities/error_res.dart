import 'package:base_core/cores/exception/app_dio_exception.dart';
import 'package:dio/dio.dart';

class ErrorRes {
  ErrorRes({this.response, this.appDioException});

  Response<dynamic>? response;
  AppDioException? appDioException;
}
