import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nortus/src/data/datasources/auth_local_datasource.dart';
import 'package:nortus/src/data/datasources/auth_remote_datasource.dart';
import 'package:nortus/src/data/datasources/news_remote_datasource.dart';
import 'package:nortus/src/data/datasources/user_remote_datasource.dart';
import 'package:nortus/src/data/http/dio_client.dart';
import 'package:nortus/src/data/repositories/auth_repository_imp.dart';
import 'package:nortus/src/data/repositories/news_repository_imp.dart';
import 'package:nortus/src/data/repositories/user_repository_imp.dart';
import 'package:nortus/src/domain/repositories/auth_repository.dart';
import 'package:nortus/src/domain/repositories/news_repository.dart';
import 'package:nortus/src/domain/repositories/user_repository.dart';
import 'package:nortus/src/domain/usecases/auth/get_keep_logged_usecase.dart';
import 'package:nortus/src/domain/usecases/auth/logout_usecase.dart';
import 'package:nortus/src/domain/usecases/auth/sign_in_usecase.dart';
import 'package:nortus/src/domain/usecases/auth/sign_up_usecase.dart';
import 'package:nortus/src/domain/usecases/news/get_categories_usecase.dart';
import 'package:nortus/src/domain/usecases/news/get_news_details_usecase.dart';
import 'package:nortus/src/domain/usecases/news/get_news_usecase.dart';
import 'package:nortus/src/domain/usecases/user/get_user_usecase.dart';
import 'package:nortus/src/domain/usecases/user/update_user_usecase.dart';
import 'package:nortus/src/presentation/blocs/auth/auth_bloc.dart';
import 'package:nortus/src/presentation/blocs/news/news_bloc.dart';
import 'package:nortus/src/presentation/blocs/user/user_bloc.dart';
import 'package:nortus/src/presentation/notifiers/keep_logged_notifier.dart';

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

  // Local datasources
  serviceLocator.registerLazySingleton<AuthLocalDatasource>(
    () => AuthLocalDatasource(),
  );

  // Repositories
  serviceLocator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImp(
      authRemoteDatasource: serviceLocator<AuthRemoteDatasource>(),
      authLocalDatasource: serviceLocator<AuthLocalDatasource>(),
    ),
  );

  serviceLocator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImp(
      newsRemoteDatasource: serviceLocator<NewsRemoteDatasource>(),
    ),
  );

  serviceLocator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImp(
      userRemoteDatasource: serviceLocator<UserRemoteDatasource>(),
    ),
  );

  // Usecases
  serviceLocator.registerLazySingleton<GetKeepLoggedUsecase>(
    () => GetKeepLoggedUsecase(repository: serviceLocator<AuthRepository>()),
  );

  serviceLocator.registerLazySingleton<SignInUsecase>(
    () => SignInUsecase(repository: serviceLocator<AuthRepository>()),
  );

  serviceLocator.registerLazySingleton<SignUpUsecase>(
    () => SignUpUsecase(repository: serviceLocator<AuthRepository>()),
  );

  serviceLocator.registerLazySingleton<GetCategoriesUsecase>(
    () => GetCategoriesUsecase(repository: serviceLocator<NewsRepository>()),
  );

  serviceLocator.registerLazySingleton<GetNewsUsecase>(
    () => GetNewsUsecase(repository: serviceLocator<NewsRepository>()),
  );

  serviceLocator.registerLazySingleton<GetNewsDetailsUsecase>(
    () => GetNewsDetailsUsecase(repository: serviceLocator<NewsRepository>()),
  );

  serviceLocator.registerLazySingleton<GetUserUsecase>(
    () => GetUserUsecase(repository: serviceLocator<UserRepository>()),
  );

  serviceLocator.registerLazySingleton<LogoutUsecase>(
    () => LogoutUsecase(repository: serviceLocator<AuthRepository>()),
  );
  serviceLocator.registerLazySingleton<UpdateUserUsecase>(
    () => UpdateUserUsecase(),
  );

  // Providers and Blocs
  serviceLocator.registerFactory(
    () => KeepLoggedNotifier(
      getKeepLoggedUsecase: serviceLocator<GetKeepLoggedUsecase>(),
    ),
  );

  serviceLocator.registerFactory<AuthBloc>(
    () => AuthBloc(
      signInUsecase: serviceLocator<SignInUsecase>(),
      signUpUsecase: serviceLocator<SignUpUsecase>(),
      logoutUsecase: serviceLocator<LogoutUsecase>(),
    ),
  );

  serviceLocator.registerFactory<NewsBloc>(
    () => NewsBloc(
      getNewsDetailsUsecase: serviceLocator<GetNewsDetailsUsecase>(),
      getCategoriesUsecase: serviceLocator<GetCategoriesUsecase>(),
      getNewsUsecase: serviceLocator<GetNewsUsecase>(),
    ),
  );

  serviceLocator.registerFactory<UserBloc>(
    () => UserBloc(
      updateUserUsecase: serviceLocator<UpdateUserUsecase>(),
      getUserUsecase: serviceLocator<GetUserUsecase>(),
    ),
  );
}