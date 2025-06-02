import 'package:base_core/cores/exception/app_dio_exception.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

/// A sealed class representing the result of an API operation.
///
/// [Success] represents the type of data returned on successful operations.
/// [Failure] represents the type of error returned on failed operations.
@freezed
sealed class ApiResult<Success, Failure> with _$ApiResult<Success, Failure> {
  /// Creates a successful result containing [data].
  const factory ApiResult.success(Success data) = ApiSuccess<Success, Failure>;

  /// Creates a failed result containing [error].
  const factory ApiResult.failure(Failure error) = ApiFailure<Success, Failure>;
}

/// Extension methods for convenient handling of ApiResult
extension ApiResultExtension<Success, Failure> on ApiResult<Success, Failure> {
  /// Returns true if this result represents a success.
  bool get isSuccess => this is ApiSuccess<Success, Failure>;

  /// Returns true if this result represents a failure.
  bool get isFailure => this is ApiFailure<Success, Failure>;

  /// Returns the success data if available, null otherwise.
  Success? get dataOrNull => switch (this) {
        ApiSuccess(:final data) => data,
        ApiFailure() => null,
      };

  /// Returns the failure error if available, null otherwise.
  Failure? get errorOrNull => switch (this) {
        ApiSuccess() => null,
        ApiFailure(:final error) => error,
      };

  /// Maps the success value to a new type while preserving failure.
  ApiResult<T, Failure> map<T>(T Function(Success data) transform) {
    return switch (this) {
      ApiSuccess(:final data) => ApiResult.success(transform(data)),
      ApiFailure(:final error) => ApiResult.failure(error),
    };
  }

  /// Maps the failure value to a new type while preserving success.
  ApiResult<Success, T> mapFailure<T>(T Function(Failure error) transform) {
    return switch (this) {
      ApiSuccess(:final data) => ApiResult.success(data),
      ApiFailure(:final error) => ApiResult.failure(transform(error)),
    };
  }

  /// Folds the result into a single value by applying the appropriate function.
  T fold<T>({
    required T Function(Success data) onSuccess,
    required T Function(Failure error) onFailure,
  }) {
    return switch (this) {
      ApiSuccess(:final data) => onSuccess(data),
      ApiFailure(:final error) => onFailure(error),
    };
  }

  /// Returns the success data or throws the failure error wrapped in an Exception.
  Success getOrThrow() {
    return switch (this) {
      ApiSuccess(:final data) => data,
      ApiFailure(:final error) =>
        throw AppDioException.fromDioError(error as DioException),
    };
  }

  /// Returns the success data or the provided default value.
  Success getOrElse(Success defaultValue) {
    return switch (this) {
      ApiSuccess(:final data) => data,
      ApiFailure() => defaultValue,
    };
  }

  /// Returns the success data or computes it using the provided function.
  Success getOrElseGet(Success Function() defaultValue) {
    return switch (this) {
      ApiSuccess(:final data) => data,
      ApiFailure() => defaultValue(),
    };
  }
}

/// Extension methods for ApiResult with Exception failures
extension ApiResultExceptionExtension<Success>
    on ApiResult<Success, Exception> {
  /// Returns the success data or throws the exception.
  Success getOrThrowException() {
    return switch (this) {
      ApiSuccess(:final data) => data,
      ApiFailure(:final error) => throw error,
    };
  }
}

/// Type alias for common API result with String error messages
typedef ApiStringResult<T> = ApiResult<T, String>;

/// Type alias for API result with Exception errors
typedef ApiExceptionResult<T> = ApiResult<T, Exception>;
