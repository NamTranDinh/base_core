part of 'api_result.dart';

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.us/rrousselGit/freezed#custom-getters-and-methods',
);

mixin _$ApiResult<Success, Failure> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Success success) success,
    required TResult Function(Failure response, Failure message) failure,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Success success)? success,
    TResult? Function(Failure failure)? failure,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult Function() orElse,
    TResult Function(Success success)? success,
    TResult Function(Failure failure)? failure,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<Success, Failure> value) success,
    required TResult Function(_Failure<Success, Failure> value) failure,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Success<Success, Failure> value)? success,
    TResult? Function(_Failure<Success, Failure> value)? failure,
  }) =>
      throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult Function() orElse,
    TResult Function(_Success<Success, Failure> value)? success,
    TResult Function(_Failure<Success, Failure> value)? failure,
  }) =>
      throw _privateConstructorUsedError;
}

class _$_Success<Success, Failure> extends _Success<Success, Failure> {
  const _$_Success(this.success) : super._();

  @override
  final Success success;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Success success) success,
    required TResult Function(Failure response, Failure message) failure,
  }) =>
      success(this.success);

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Success success)? success,
    TResult? Function(Failure failure)? failure,
  }) =>
      success?.call(this.success);

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult Function() orElse,
    TResult Function(Success success)? success,
    TResult Function(Failure failure)? failure,
  }) {
    if (success != null) {
      return success(this.success);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<Success, Failure> value) success,
    required TResult Function(_Failure<Success, Failure> value) failure,
  }) =>
      success(this);

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Success<Success, Failure> value)? success,
    TResult? Function(_Failure<Success, Failure> value)? failure,
  }) =>
      success?.call(this);

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult Function() orElse,
    TResult Function(_Success<Success, Failure> value)? success,
    TResult Function(_Failure<Success, Failure> value)? failure,
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success<Success, Failure> extends ApiResult<Success, Failure> {
  const factory _Success(Success success) = _$_Success<Success, Failure>;

  const _Success._() : super._();

  @override
  Success get success;
}

class _$_Failure<Success, Failure> extends _Failure<Success, Failure> {
  const _$_Failure(this.failure, this.message) : super._();

  @override
  final Failure failure;

  @override
  final Failure message;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(Success success) success,
    required TResult Function(Failure response, Failure message) failure,
  }) =>
      failure(this.failure, this.message);

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Success success)? success,
    TResult? Function(Failure failure)? failure,
  }) =>
      failure?.call(this.failure);

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    required TResult Function() orElse,
    TResult Function(Success success)? success,
    TResult Function(Failure failure)? failure,
  }) {
    if (failure != null) {
      return failure(this.failure);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<Success, Failure> value) success,
    required TResult Function(_Failure<Success, Failure> value) failure,
  }) =>
      failure(this);

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Success<Success, Failure> value)? success,
    TResult? Function(_Failure<Success, Failure> value)? failure,
  }) =>
      failure?.call(this);

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    required TResult Function() orElse,
    TResult Function(_Success<Success, Failure> value)? success,
    TResult Function(_Failure<Success, Failure> value)? failure,
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure<Success, Failure> extends ApiResult<Success, Failure> {
  const factory _Failure(Failure failure, Failure message) =
      _$_Failure<Success, Failure>;

  const _Failure._() : super._();

  @override
  Failure get failure;

  @override
  Failure get message;
}
