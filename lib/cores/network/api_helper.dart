import 'dart:convert';

import 'package:core_utils/core_utils.dart';
import 'package:dio/dio.dart';

/// Enhanced ApiHelper that throws DioException and returns T directly
class ApiHelper {
  ApiHelper({required this.dio});

  final Dio dio;

  /// Generic request method that handles all HTTP methods
  Future<T> _makeRequest<T>({
    required String method,
    required String path,
    required T Function(T json) parser,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Options? options,
  }) async {
    final Response response;

    switch (method.toUpperCase()) {
      case 'GET':
        response = await dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
        );
      case 'POST':
        response = await dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        );
      case 'PUT':
        response = await dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        );
      case 'DELETE':
        response = await dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        );
      case 'PATCH':
        response = await dio.patch(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
        );
      default:
        throw DioException(
          requestOptions: RequestOptions(path: path),
          message: 'Unsupported HTTP method: $method',
        );
    }

    // Check if response is successful
    if (response.statusCode == null || !response.statusCode!.success) {
      throw DioException.badResponse(
        statusCode: response.statusCode ?? 0,
        requestOptions: response.requestOptions,
        response: response,
      );
    }

    // Parse the response data
    try {
      final parsedData = parser(_normalizeResponseData(response.data));
      return parsedData;
    } on Exception catch (e, stackTrace) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: e,
        stackTrace: stackTrace,
        message: 'Failed to parse response: $e',
      );
    }
  }

  /// Normalize response data to ensure consistent JSON handling
  dynamic _normalizeResponseData(dynamic data) {
    if (data == null) {
      return null;
    }

    // If data is already a Map or List, return as-is
    if (data is Map<String, dynamic> || data is List) {
      return data;
    }

    // If data is a string, try to decode it as JSON
    if (data is String) {
      try {
        return json.decode(data);
      } on Exception catch (_) {
        return data;
      }
    }

    // For other types, convert through JSON to normalize
    try {
      return json.decode(json.encode(data));
    } on Exception catch (_) {
      return data;
    }
  }

  // HTTP Method implementations using the generic _makeRequest method

  Future<T> get<T>({
    required String path,
    required T Function(dynamic json) parser,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _makeRequest<T>(
      method: 'GET',
      path: path,
      parser: parser,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<T> post<T>({
    required String path,
    required T Function(T json) parser,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _makeRequest<T>(
      method: 'POST',
      path: path,
      parser: parser,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<T> put<T>({
    required String path,
    required T Function(dynamic json) parser,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _makeRequest<T>(
      method: 'PUT',
      path: path,
      parser: parser,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<T> delete<T>({
    required String path,
    required T Function(dynamic json) parser,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _makeRequest<T>(
      method: 'DELETE',
      path: path,
      parser: parser,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<T> patch<T>({
    required String path,
    required T Function(dynamic json) parser,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return _makeRequest<T>(
      method: 'PATCH',
      path: path,
      parser: parser,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  // Convenience methods for common use cases

  /// GET request expecting a List response
  Future<List<T>> getList<T>({
    required String path,
    required T Function(Map<String, dynamic> json) itemParser,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return get<List<T>>(
      path: path,
      parser: (json) {
        if (json is! List) {
          throw Exception('Expected List but got ${json.runtimeType}');
        }
        return json
            .map((item) => itemParser(item as Map<String, dynamic>))
            .toList();
      },
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// GET request expecting a single object response
  Future<T> getObject<T>({
    required String path,
    required T Function(Map<String, dynamic> json) parser,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return get<T>(
      path: path,
      parser: (json) => parser(json as Map<String, dynamic>),
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// POST request with JSON body
  Future<T> postJson<T>({
    required String path,
    required T Function(dynamic json) parser,
    required Map<String, dynamic> body,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return post<T>(
      path: path,
      parser: parser,
      data: body,
      queryParameters: queryParameters,
      options: options?.copyWith(
            contentType: Headers.jsonContentType,
          ) ??
          Options(contentType: Headers.jsonContentType),
    );
  }

  /// Download file
  Future<String> downloadFile({
    required String path,
    required String savePath,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      await dio.download(
        path,
        savePath,
        queryParameters: queryParameters,
        options: options,
        onReceiveProgress: onReceiveProgress,
      );
      return savePath;
    } on Exception catch (e, stackTrace) {
      if (e is DioException) {
        rethrow;
      }
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: e,
        stackTrace: stackTrace,
        message: 'Download failed: $e',
      );
    }
  }

  /// Upload file
  Future<T> uploadFile<T>({
    required String path,
    required String filePath,
    required T Function(dynamic json) parser,
    String fieldName = 'file',
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    try {
      final formData = FormData.fromMap({
        ...?data,
        fieldName: await MultipartFile.fromFile(filePath),
      });

      return post<T>(
        path: path,
        parser: parser,
        data: formData,
        queryParameters: queryParameters,
        options: options,
      );
    } on Exception catch (e, stackTrace) {
      if (e is DioException) {
        rethrow;
      }
      throw DioException(
        requestOptions: RequestOptions(path: path),
        error: e,
        stackTrace: stackTrace,
        message: 'Upload failed: $e',
      );
    }
  }
}
