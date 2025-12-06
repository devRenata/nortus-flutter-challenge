import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nortus/src/data/datasources/auth_remote_datasource.dart';
import 'package:nortus/src/data/datasources/news_remote_datasource.dart';
import 'package:nortus/src/data/datasources/user_remote_datasource.dart';
import 'package:nortus/src/data/http/dio_client.dart';
import 'package:nortus/src/data/repositories/auth_repository_imp.dart';
import 'package:nortus/src/domain/repositories/auth_repository.dart';

final serviceLocator = GetIt.instance;

void setupDependencies() async {
  // Http client
  serviceLocator.registerLazySingleton<Dio>(
    () => DioClient().dio,
  );

  // Remote datasources
  serviceLocator.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasource(dio: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<NewsRemoteDatasource>(
    () => NewsRemoteDatasource(dio: serviceLocator()),
  );

  serviceLocator.registerLazySingleton<UserRemoteDatasource>(
    () => UserRemoteDatasource(dio: serviceLocator()),
  );

  // Repositories
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(
      authRemoteDatasource: serviceLocator<AuthRemoteDatasource>(),
    ),
  );
}