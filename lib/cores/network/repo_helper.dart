import 'package:base_core/cores/entities/error_res.dart';
import 'package:base_core/cores/exception/app_dio_exception.dart';
import 'package:base_core/cores/network/api_result.dart';
import 'package:dio/dio.dart';

mixin RepositoryHelper {
  Future<ApiResult<T, ErrorRes>> checkApiResult<T>({
    required Future<T> apiCallback,
  }) async {
    try {
      final items = await apiCallback;
      return ApiResult.success(items);
    } on DioException catch (e) {
      final response = e.response;
      final appDioException = AppDioException.fromDioError(e);
      final errorRes = ErrorRes(
        response: response,
        appDioException: appDioException,
      );
      return ApiResult.failure(errorRes);
    }
  }
}
