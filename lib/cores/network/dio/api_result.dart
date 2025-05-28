import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_result.freezed.dart';

@freezed
class ApiResult<Success, Failure> with _$ApiResult<Success, Failure> {
  const ApiResult._();

  const factory ApiResult.success(Success success) = _Success;

  const factory ApiResult.failure(Failure response, Failure message) = _Failure;

  bool get isSuccess => when(success: (_) => true, failure: (_, __) => false);

  bool get isFailure => when(success: (_) => false, failure: (_, __) => true);

  Success? get success =>
      when(success: (success) => success, failure: (failure, message) => null);

  Failure? get failure =>
      when(success: (success) => null, failure: (failure, message) => failure);

  Failure? get message =>
      when(success: (success) => null, failure: (failure, message) => failure);

  ApiResult<ResultType, Failure?> flatMap<ResultType>(
    ApiResult<ResultType, Failure> Function(Success?) mapper,
  ) =>
      when(
        success: (success) => mapper(success),
        failure: ApiResult.failure,
      );

  Success? getOrElse<ResultType>(Success Function() successFunction) => when(
        success: (success) => success,
        failure: (failure, message) => successFunction(),
      );

  ApiResult<ResultType, Failure?> mapSuccess<ResultType>(
    ResultType Function(Success?) mapper,
  ) =>
      when(
        success: (success) =>
            ApiResult<ResultType, Failure>.success(mapper(success)),
        failure: ApiResult<ResultType, Failure?>.failure,
      );

  @override
  String toString() => when(
        success: (success) =>
            success == null ? 'Success: (null)' : 'Success: $success',
        failure: (failure, message) =>
            failure == null ? 'Failure: (null)' : 'Failure: $failure',
      );
}
