import 'package:base_core/blocs/app/app_cubit.dart';
import 'package:base_core/cores/constants/system.dart';
import 'package:base_core/cores/network/dio/api_helper.dart';
import 'package:base_core/cores/network/dio/dio_client.dart';
import 'package:base_core/routes/app_router.dart';
import 'package:core_utils/core_utils.dart';
import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDI() async {
  /**
   * ┌──────────────────────────────────────────────────────────────────────────
   * │ cubits
   * └──────────────────────────────────────────────────────────────────────────
   */
  getIt

    /**
   * ┌──────────────────────────────────────────────────────────────────────────
   * │ repositories
   * └──────────────────────────────────────────────────────────────────────────
   */

    /**
   * ┌──────────────────────────────────────────────────────────────────────────
   * │ storage
   * └──────────────────────────────────────────────────────────────────────────
   */
    ..registerLazySingletonAsync<BaseLocalStorage>(
      BaseLocalStorage.getInstance,
    )
    ..registerLazySingleton<BaseSecureStorage>(
      BaseSecureStorage.new,
    )
    /**
   * ┌──────────────────────────────────────────────────────────────────────────
   * │ dio
   * └──────────────────────────────────────────────────────────────────────────
   */
    ..registerLazySingleton<ApiHelper>(
      () => ApiHelper(dio: getIt<DioClient>().dio),
    )
    ..registerLazySingleton<DioClient>(
      () => DioClient(getIt<Dio>()),
    )
    ..registerLazySingleton<Dio>(
      Dio.new,
    )
    /**
   * ┌──────────────────────────────────────────────────────────────────────────
   * │ configs
   * └──────────────────────────────────────────────────────────────────────────
   */
    ..registerSingleton<LanguageManager>(LanguageManager.instance)
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<AppCubit>(AppCubit())
    ..registerSingleton<EventBus>(EventBus(sync: true));
}
