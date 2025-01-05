import 'package:base_core/configs/dio/dio_exception.dart';
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final exceptionType = getExceptionType(err.type);
    switch (exceptionType) {
      case ExceptionType.cancel:
      case ExceptionType.connectionTimeout:
      case ExceptionType.receiveTimeout:
      case ExceptionType.sendTimeout:
      case ExceptionType.socketException:
      case ExceptionType.unexpectedError:
      case ExceptionType.unknownError:
      case ExceptionType.badResponse:
    }

    super.onError(err, handler);
  }
}
