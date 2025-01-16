import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart' show immutable;

enum Status { init, empty, loading, failure, success }

@immutable
class BaseCubitState<T> extends Equatable {
  const BaseCubitState({this.data, this.error, required this.status});

  factory BaseCubitState.init() => const BaseCubitState(status: Status.init);

  factory BaseCubitState.empty() => const BaseCubitState(status: Status.empty);

  factory BaseCubitState.loading() =>
      const BaseCubitState(status: Status.loading);

  factory BaseCubitState.failure(String error) =>
      BaseCubitState(error: error, status: Status.failure);

  factory BaseCubitState.success(T? data) =>
      BaseCubitState(data: data, status: Status.success);
  final T? data;
  final String? error;
  final Status status;

  BaseCubitState<T> copyWith({
    T? data,
    String? error,
    Status? status,
  }) {
    return BaseCubitState<T>(
      data: data ?? this.data,
      error: error ?? this.error,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [data, error, status];
}
