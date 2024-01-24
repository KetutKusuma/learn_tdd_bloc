import 'package:get_it/get_it.dart';
import 'package:learn_tdd_bloc/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:learn_tdd_bloc/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/usecases/create_user.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/usecases/get_users.dart';
import 'package:learn_tdd_bloc/src/authentication/persentation/cubit/authentication_cubit.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // =============== INJECTION ====================
  // versi 1

  // ======= bloc or cubit (logic) =========
  sl
    ..registerFactory(() => AuthenticationCubit(
          createUser: sl(),
          getUsers: sl(),
        ))
    // ======= use cases ===========
    ..registerLazySingleton(() => CreateUser(
          sl(),
        ))
    ..registerLazySingleton(() => GetUsers(
          sl(),
        ))

    // ====== repository =================
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImplementation(sl()))

    // ====== data source =======================
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))

    // ===== external dependencies ==================
    ..registerLazySingleton(http.Client.new);

  // versi 2
  // ===== bloc or cubit =============
  // sl.registerFactory(
  //     () => AuthenticationCubit(createUser: sl(), getUsers: sl()));

  // // ===== usecase ====================
  // sl.registerLazySingleton(() => CreateUser(sl()));
  // sl.registerLazySingleton(() => GetUsers(sl()));

  // // ===== repository ================
  // sl.registerLazySingleton<AuthenticationRepository>(
  //     () => AuthenticationRepositoryImplementation(sl()));

  // // ===== data source ===============
  // sl.registerLazySingleton<AuthenticationRemoteDataSource>(
  //     () => AuthRemoteDataSrcImpl(sl()));

  // // ===== network or http (client) =====
  // sl.registerLazySingleton(() => http.Client);
}
