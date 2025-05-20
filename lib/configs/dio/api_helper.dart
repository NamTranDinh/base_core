import 'dart:convert';

import 'package:core_utils/core_utils.dart';
import 'package:dio/dio.dart';

class ApiHelper {
  ApiHelper({required this.dio});

  final Dio dio;

  Future<T> post<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic json) getJsonCallback,
    Options? options,
    dynamic body,
  }) async {
    final response = await dio.post(
      path,
      data: body,
      queryParameters: queryParameters,
      options: options,
    );

    if (response.statusCode != null && response.statusCode!.success) {
      final t = getJsonCallback(json.decode(json.encode(response.data)));
      return t;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  Future<T> put<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(Map<String, dynamic> json) getJsonCallback,
    dynamic body,
    Options? options,
  }) async {
    final response = await dio.put(
      path,
      data: body,
      queryParameters: queryParameters,
      options: options,
    );

    if (response.statusCode.success) {
      final t = getJsonCallback(json.decode(json.encode(response.data)));
      return t;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  Future<T> delete<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    required T Function(dynamic json) getJsonCallback,
    dynamic data,
    Options? options,
  }) async {
    final response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    if (response.statusCode.success) {
      final t = getJsonCallback(json.decode(json.encode(response.data)));
      return t;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  Future<T> get<T>({
    required String path,
    required T Function(dynamic json) getJsonCallback,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
    final data = getJsonCallback(
      json.decode(json.encode(response.data)),
    );

    if (response.statusCode.success) {
      return data;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }

  Future<T> patch<T>({
    required String path,
    required T Function(dynamic json) getJsonCallback,
    Map<String, dynamic>? queryParameters,
    dynamic body,
    Options? options,
  }) async {
    final response = await dio.patch(
      path,
      queryParameters: queryParameters,
      data: body,
      options: options,
    );
    final data = getJsonCallback(
      json.decode(json.encode(response.data)),
    );

    if (response.statusCode.success) {
      return data;
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
      );
    }
  }
}
