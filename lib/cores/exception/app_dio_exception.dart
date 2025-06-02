// Assuming you have an extension method '.tr()' for localization
// e.g., import 'package:get/get.dart'; or your own localization solution

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

enum ExceptionType {
  cancel,
  connectionTimeout,
  receiveTimeout,
  badResponse,
  sendTimeout,
  socketException,
  badCertificate,
  connectionError,
  unexpectedError,
  unknownError,
}

class AppDioException implements Exception {
  AppDioException._(this.message, this.exceptionType, {this.originalException});

  factory AppDioException.fromDioError(DioException dioError) {
    String message;
    ExceptionType exceptionType;

    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = 'error_system.cancel_request'.tr();
        exceptionType = ExceptionType.cancel;
      case DioExceptionType.connectionTimeout:
        message = 'error_system.connection_time_out'.tr();
        exceptionType = ExceptionType.connectionTimeout;
      case DioExceptionType.receiveTimeout:
        message = 'error_system.receive_time_out'.tr();
        exceptionType = ExceptionType.receiveTimeout;
      case DioExceptionType.badResponse:
        message = _handleDioResponseError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        exceptionType = ExceptionType.badResponse;
      case DioExceptionType.sendTimeout:
        message = 'error_system.send_time_out'.tr();
        exceptionType = ExceptionType.sendTimeout;
      case DioExceptionType.badCertificate:
        message = 'error_system.bad_certificate'.tr();
        exceptionType = ExceptionType.badCertificate;
      case DioExceptionType.connectionError:
        message = 'error_system.connection_error'.tr();
        exceptionType = ExceptionType.connectionError;
      case DioExceptionType.unknown:
        if (dioError.error is SocketException) {
          message = 'error_system.socket_exception'.tr();
          exceptionType = ExceptionType.socketException;
        } else if (dioError.message?.contains('Socket') ?? false) {
          message = 'error_system.socket_exception'.tr();
          exceptionType = ExceptionType.socketException;
        } else {
          message = 'error_system.unexpected_error'.tr();
          exceptionType = ExceptionType.unexpectedError;
        }
    }
    return AppDioException._(
      message,
      exceptionType,
      originalException: dioError,
    );
  }

  final String message;
  final ExceptionType exceptionType;
  final DioException? originalException;

  // Renamed for clarity and made static as it doesn't depend on instance state
  static String _handleDioResponseError(int? statusCode, dynamic errorData) {
    // Implement more robust error handling based on status code and errorData
    if (statusCode != null) {
      if (statusCode >= 400 && statusCode < 500) {
        return 'error_system.client_error'.tr(args: [statusCode.toString()]);
      } else if (statusCode >= 500) {
        return 'error_system.server_error'.tr(args: [statusCode.toString()]);
      }
    }
    // Try to get a message from the errorData if available
    if (errorData != null &&
        errorData is Map &&
        errorData.containsKey('message') &&
        errorData['message'] is String) {
      return errorData['message'];
    }
    return 'error_system.bad_response_generic'.tr();
  }

  @override
  String toString() {
    return 'AppDioException: $message (Type: $exceptionType)';
  }

  static ExceptionType fromDioExceptionType(DioExceptionType dioExceptionType) {
    switch (dioExceptionType) {
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
      case DioExceptionType.badCertificate:
        return ExceptionType.badCertificate;
      case DioExceptionType.connectionError:
        return ExceptionType.connectionError;
      case DioExceptionType.unknown:
        return ExceptionType.unknownError;
    }
  }
}
