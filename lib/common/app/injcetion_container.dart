import 'package:agranom_ai/data/repositories/custom_dio_client.dart';
import 'package:agranom_ai/data/repositories/home_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initInjection() async {
  getIt.registerLazySingleton(
    () => Dio(),
  );
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);
  // await authInit();
  await homeInit();
}

// Future<void> authInit() async {
//   getIt
//     ..registerLazySingleton<LoginUsecase>(() => LoginUsecase(authRepo: getIt()))
//     ..registerLazySingleton<RegisterUsecases>(
//       () => RegisterUsecases(authRepo: getIt()),
//     )
//     ..registerLazySingleton<DioClient>(
//       () => DioClient(),
//     )
//     ..registerLazySingleton<AuthRepo>(
//         () => AuthRepoImpl(authRemoteDataSource: getIt()))
//     ..registerLazySingleton<AuthRemoteDataSource>(
//         () => AuthRemoteDataSourceImpl())
//     ..registerLazySingleton(
//       () => AuthProvider(),
//     );
// }

// home
Future<void> homeInit() async {
  getIt
  ..registerLazySingleton<DioClient>(() => DioClient(),)
  ..registerLazySingleton<HomeRepo>(
        () => HomeRepoImpl());
}
