import 'package:base_core/cores/constants/system.dart';
import 'package:base_core/cores/network/api_helper.dart';
import 'package:base_core/cores/network/dio_client.dart';
import 'package:base_core/features/app/presentation/bloc/app_cubit.dart';
import 'package:base_core/features/login/data/datasources/login_datasource.dart';
import 'package:base_core/features/login/domain/repositories/login_repository.dart';
import 'package:base_core/features/login/presentation/bloc/login_cubit.dart';
import 'package:base_core/routes/app_router.dart';
import 'package:core_utils/core_utils.dart';
import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

Future<void> initDI() async {
  getIt
    /**
   * ┌──────────────────────────────────────────────────────────────────────────
   * │ cubits
   * └──────────────────────────────────────────────────────────────────────────
   */
    ..registerSingleton<AppCubit>(AppCubit())
    ..registerFactory<LoginCubit>(
      () => LoginCubit(loginRepository: getIt<LoginRepository>()),
    )

    /**
   * ┌──────────────────────────────────────────────────────────────────────────
   * │ repositories
   * └──────────────────────────────────────────────────────────────────────────
   */
    ..registerLazySingleton<LoginRepository>(
      () => LoginDatasource(apiHelper: getIt<ApiHelper>()),
    )
    /**
   * ┌──────────────────────────────────────────────────────────────────────────
   * │ storage
   * └──────────────────────────────────────────────────────────────────────────
   */
    ..registerLazySingleton<BaseSecureStorage>(
      BaseSecureStorage.new,
    )
    /**
   * ┌──────────────────────────────────────────────────────────────────────────
   * │ dio
   * └──────────────────────────────────────────────────────────────────────────
   */
    ..registerLazySingleton<DioClient>(
      () => DioClient(getIt<Dio>()),
    )
    ..registerLazySingleton<ApiHelper>(
      () => ApiHelper(dio: getIt<DioClient>().dio),
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
    ..registerSingleton<EventBus>(EventBus(sync: true));
}
