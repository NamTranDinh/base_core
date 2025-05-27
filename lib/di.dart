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
   * │ dio
   * └──────────────────────────────────────────────────────────────────────────
   */
      // ..registerLazySingleton<ApiHelper>(
      //   () => ApiHelper(dio: getIt<DioClient>().dio),
      // )
      // ..registerLazySingleton<DioClient>(
      //   () => DioClient(getIt<Dio>()),
      // )
      // ..registerLazySingleton<DioFile>(
      //   () => DioFile(Dio()),
      // )
      // ..registerLazySingleton<Dio>(
      //   Dio.new,
      // )
      /**
   * ┌──────────────────────────────────────────────────────────────────────────
   * │ socket
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
      .registerSingleton<EventBus>(EventBus(sync: true));
}
