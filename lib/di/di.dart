import 'package:base_core/blocs/app/app_cubit.dart';
import 'package:base_core/configs/dio/api_helper.dart';
import 'package:base_core/configs/dio/dio_client.dart';
import 'package:base_core/configs/system.dart';
import 'package:base_core/routes/app_router.dart';
import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

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
    // ..registerLazySingleton<AppStorage>(
    //   AppStorage.new,
    // )
    // ..registerLazySingleton<SecureStorage>(
    //   SecureStorage.new,
    // )
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
    ..registerSingleton<LanguageManager>(LanguageManager())
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<AppCubit>(AppCubit())
    ..registerSingleton<EventBus>(EventBus(sync: true));
}
