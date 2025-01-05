import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

enum ExceptionType {
  cancel,
  connectionTimeout,
  receiveTimeout,
  badResponse,
  sendTimeout,
  socketException,
  unexpectedError,
  unknownError,
}

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'errors_system.cancel_request'.tr();
        exceptionType = ExceptionType.cancel;
      case DioExceptionType.connectionTimeout:
        message = 'error_system.connection_time_out'.tr();
        exceptionType = ExceptionType.connectionTimeout;
      case DioExceptionType.receiveTimeout:
        message = 'error_system.receive_time_out'.tr();
        exceptionType = ExceptionType.receiveTimeout;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        exceptionType = ExceptionType.badResponse;
      case DioExceptionType.sendTimeout:
        message = 'error_system.send_time_out'.tr();
        exceptionType = ExceptionType.sendTimeout;
      case DioExceptionType.unknown:
        if (dioError.message?.contains('Socket') ?? false) {
          message = 'error_system.socket_exception'.tr();
          exceptionType = ExceptionType.socketException;
          break;
        }
        message = 'error_system.unexpected_error'.tr();
        exceptionType = ExceptionType.unexpectedError;
      default:
        message = 'error_system.unknown_error'.tr();
        exceptionType = ExceptionType.unknownError;
    }
  }

  late String message;
  late ExceptionType exceptionType;

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'error_system.bad_request'.tr();
      case 401:
        return 'error_system.unauthorized'.tr();
      case 403:
        return 'error_system.forbidden'.tr();
      case 404:
        return 'error_system.not_found'.tr();
      case 422:
        return 'error_system.duplicate_email'.tr();
      case 500:
        return 'error_system.internal_server_error'.tr();
      case 502:
        return 'error_system.bad_gateway'.tr();
      default:
        return 'error_system.unknown_error'.tr();
    }
  }

  @override
  String toString() {
    return 'DioExceptions{message: $message, exceptionType: $exceptionType}';
  }
}

ExceptionType getExceptionType(DioExceptionType dioErrorType) {
  switch (dioErrorType) {
    case DioExceptionType.cancel:
      return ExceptionType.cancel;
    case DioExceptionType.connectionTimeout:
      return ExceptionType.connectionTimeout;
    case DioExceptionType.receiveTimeout:
      return ExceptionType.receiveTimeout;
    case DioExceptionType.badResponse:
      return ExceptionType.badResponse;
    case DioExceptionType.sendTimeout:
      return ExceptionType.sendTimeout;
    case DioExceptionType.unknown:
      if (dioErrorType.name.contains('Socket')) {
        return ExceptionType.socketException;
      }
      return ExceptionType.unexpectedError;
    default:
      return ExceptionType.unknownError;
  }
}
