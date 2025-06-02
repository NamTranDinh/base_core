// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApiResult<Success, Failure> {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApiResult<Success, Failure>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ApiResult<$Success, $Failure>()';
  }
}

/// @nodoc
class $ApiResultCopyWith<Success, Failure, $Res> {
  $ApiResultCopyWith(ApiResult<Success, Failure> _,
      $Res Function(ApiResult<Success, Failure>) __);
}

/// @nodoc

class ApiSuccess<Success, Failure> implements ApiResult<Success, Failure> {
  const ApiSuccess(this.data);

  final Success data;

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApiSuccessCopyWith<Success, Failure, ApiSuccess<Success, Failure>>
      get copyWith => _$ApiSuccessCopyWithImpl<Success, Failure,
          ApiSuccess<Success, Failure>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApiSuccess<Success, Failure> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() {
    return 'ApiResult<$Success, $Failure>.success(data: $data)';
  }
}

/// @nodoc
abstract mixin class $ApiSuccessCopyWith<Success, Failure, $Res>
    implements $ApiResultCopyWith<Success, Failure, $Res> {
  factory $ApiSuccessCopyWith(ApiSuccess<Success, Failure> value,
          $Res Function(ApiSuccess<Success, Failure>) _then) =
      _$ApiSuccessCopyWithImpl;
  @useResult
  $Res call({Success data});
}

/// @nodoc
class _$ApiSuccessCopyWithImpl<Success, Failure, $Res>
    implements $ApiSuccessCopyWith<Success, Failure, $Res> {
  _$ApiSuccessCopyWithImpl(this._self, this._then);

  final ApiSuccess<Success, Failure> _self;
  final $Res Function(ApiSuccess<Success, Failure>) _then;

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? data = freezed,
  }) {
    return _then(ApiSuccess<Success, Failure>(
      freezed == data
          ? _self.data
          : data // ignore: cast_nullable_to_non_nullable
              as Success,
    ));
  }
}

/// @nodoc

class ApiFailure<Success, Failure> implements ApiResult<Success, Failure> {
  const ApiFailure(this.error);

  final Failure error;

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ApiFailureCopyWith<Success, Failure, ApiFailure<Success, Failure>>
      get copyWith => _$ApiFailureCopyWithImpl<Success, Failure,
          ApiFailure<Success, Failure>>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ApiFailure<Success, Failure> &&
            const DeepCollectionEquality().equals(other.error, error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(error));

  @override
  String toString() {
    return 'ApiResult<$Success, $Failure>.failure(error: $error)';
  }
}

/// @nodoc
abstract mixin class $ApiFailureCopyWith<Success, Failure, $Res>
    implements $ApiResultCopyWith<Success, Failure, $Res> {
  factory $ApiFailureCopyWith(ApiFailure<Success, Failure> value,
          $Res Function(ApiFailure<Success, Failure>) _then) =
      _$ApiFailureCopyWithImpl;
  @useResult
  $Res call({Failure error});
}

/// @nodoc
class _$ApiFailureCopyWithImpl<Success, Failure, $Res>
    implements $ApiFailureCopyWith<Success, Failure, $Res> {
  _$ApiFailureCopyWithImpl(this._self, this._then);

  final ApiFailure<Success, Failure> _self;
  final $Res Function(ApiFailure<Success, Failure>) _then;

  /// Create a copy of ApiResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = freezed,
  }) {
    return _then(ApiFailure<Success, Failure>(
      freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as Failure,
    ));
  }
}

// dart format on
