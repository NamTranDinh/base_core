import 'package:base_core/commons/app_components/alerts/alert_overlay.dart';
import 'package:base_core/cores/exception/app_dio_exception.dart';
import 'package:base_core/cores/utils/app_overlay_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
        _showSystemAlert(err);
      case ExceptionType.connectionTimeout:
        _showSystemAlert(err);
      case ExceptionType.receiveTimeout:
        _showSystemAlert(err);
      case ExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        if (statusCode == 401) {
        } else if (statusCode == 403) {
        } else if (statusCode != null && statusCode >= 500) {
          _showSystemAlert(err);
        }
      case ExceptionType.sendTimeout:
        _showSystemAlert(err);
      case ExceptionType.socketException:
        _showSystemAlert(err);
      case ExceptionType.badCertificate:
        _showSystemAlert(err);
      case ExceptionType.connectionError:
        _showSystemAlert(err);
      case ExceptionType.unexpectedError:
        _showSystemAlert(err);
      case ExceptionType.unknownError:
        _showSystemAlert(err);
    }

    handler.next(err);
  }

  void _showSystemAlert(DioException err) {
    AppOverlayManager.instance.showTemporaryEntry(
      OverlayEntry(
        builder: (context) => AppAlertOverlay.failure(
          message: err.message,
        ),
      ),
    );
  }
}
