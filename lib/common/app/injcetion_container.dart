import 'package:agranom_ai/bloc/history_bloc/history_bloc.dart';
import 'package:agranom_ai/data/repositories/auth_repository.dart';
import 'package:agranom_ai/data/repositories/chat_repo.dart';
import 'package:agranom_ai/data/repositories/custom_dio_client.dart';
import 'package:agranom_ai/data/repositories/history_repository.dart';
import 'package:agranom_ai/data/repositories/home_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> initInjection() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  final dio = Dio();
  getIt.registerSingleton<Dio>(dio);

  // Repositories

  getIt.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(getIt<Dio>()));
  homeInit();
}

// home
Future<void> homeInit() async {
  getIt
    ..registerLazySingleton<DioClient>(
      () => DioClient(),
    )
    ..registerLazySingleton<HistoryRepository>(
      () => HistoryRepository(),
    )
    ..registerLazySingleton(
      () => HistoryBloc(getIt<HistoryRepository>()),
    )
    ..registerLazySingleton(() => ChatRepository())
    ..registerLazySingleton<HomeRepo>(() => HomeRepoImpl());
}
