// import 'package:base_core/src/base_cubit/base_cubit_state.dart';
// import 'package:base_core/src/base_dio/api_result.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// enum ApiOperation { select, create, update, delete }
//
// class BaseCubit<T> extends Cubit<BaseCubitState<List<T>>> {
//   BaseCubit() : super(BaseCubitState.loading());
//
//   ApiOperation operation = ApiOperation.select;
//
//   _checkFailureOrSuccess(ApiResult failureOrSuccess) {
//     failureOrSuccess.when(
//       failure: (String failure) {
//         emit(BaseCubitState.failure(failure));
//       },
//       success: (_) {
//         emit(BaseCubitState.success(null));
//       },
//     );
//   }
//
//   _apiOperationTemplate(T apiCallback) async {
//     emit(BaseCubitState.loading());
//     ApiResult failureOrSuccess = await apiCallback;
//     _checkFailureOrSuccess(failureOrSuccess);
//   }
//
//   Future<void> createItem(Future<ApiResult> apiCallback) async {
//     operation = ApiOperation.create;
//     _apiOperationTemplate(apiCallback);
//   }
//
//   Future<void> updateItem(Future<ApiResult> apiCallback) async {
//     operation = ApiOperation.update;
//     _apiOperationTemplate(apiCallback);
//   }
//
//   Future<void> deleteItem(Future<ApiResult> apiCallback) async {
//     operation = ApiOperation.delete;
//     _apiOperationTemplate(apiCallback);
//   }
//
//   Future<void> getItems(Future<ApiResult<List<T>>> apiCallback) async {
//     operation = ApiOperation.select;
//     emit(BaseCubitState.loading());
//     ApiResult<List<T>> failureOrSuccess = await apiCallback;
//
//     failureOrSuccess.when(
//       failure: (String failure) {
//         emit(BaseCubitState.failure(failure));
//       },
//       success: (List<T> items) {
//         if (items.isEmpty) {
//           emit(BaseCubitState.empty());
//         } else {
//           emit(BaseCubitState.success(items));
//         }
//       },
//     );
//   }
// }
