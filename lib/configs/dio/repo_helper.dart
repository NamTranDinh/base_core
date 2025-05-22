import 'package:base_core/configs/dio/api_result.dart';
import 'package:base_core/configs/dio/dio_exception.dart';
import 'package:dio/dio.dart';

mixin RepositoryHelper {
  Future<ApiResult<T, dynamic>> check<T>(Future<T> apiCallback) async {
    try {
      final items = await apiCallback;
      return ApiResult.success(items);
    } on DioException catch (e) {
      final response = e.response;
      final message = AppDioException.fromDioError(e).message;
      return ApiResult.failure(response, message);
    }
  }
}
