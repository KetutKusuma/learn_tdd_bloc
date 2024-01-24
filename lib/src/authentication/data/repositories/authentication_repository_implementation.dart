import 'package:dartz/dartz.dart';
import 'package:learn_tdd_bloc/core/errors/exception.dart';
import 'package:learn_tdd_bloc/core/errors/failure.dart';
import 'package:learn_tdd_bloc/core/utils/typedef.dart';
import 'package:learn_tdd_bloc/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImplementation
    implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _datasourceRemote;
  const AuthenticationRepositoryImplementation(this._datasourceRemote);

  @override
  ResultVoid createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // TEST DRIVEN DEVELOPMENT
    //
    //**
    // CALL THE REMOTE DATA SOURCE
    // check if the method returns the proper data
    // make sure that it returns the the proper data if thre is no exception
    // check if when the remote datasource throws an exception
    // we return a failure and if it doesn't throw an exception
    // we return the actual data*/
    // TODO: implement createUser
    try {
      await _datasourceRemote.createUser(
        createdAt: createdAt,
        name: name,
        avatar: avatar,
      );
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }

    return const Right(null);
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _datasourceRemote.getUsers();
      return Right(result);
    } on APIException catch (e) {
      return Left(
        APIFailure.fromException(e),
      );
    }
  }
}
