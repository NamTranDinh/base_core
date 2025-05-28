import 'package:base_core/cores/exception/dio_exception.dart';
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  // onRequest and onResponse can be removed if they only call super.
  // If you need to add custom logic, remember to use handler.next(options/response).

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final exceptionType = AppDioException.fromDioExceptionType(err.type);

    switch (exceptionType) {
      case ExceptionType.cancel:
      case ExceptionType.connectionTimeout:
      case ExceptionType.receiveTimeout:
      case ExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        if (statusCode == 401) {
        } else if (statusCode == 403) {
        } else if (statusCode != null && statusCode >= 500) {}
      case ExceptionType.sendTimeout:
      case ExceptionType.socketException:
      case ExceptionType.badCertificate:
      case ExceptionType.connectionError:
      case ExceptionType.unexpectedError:
      case ExceptionType.unknownError:
    }

    handler.next(err);
  }
}
