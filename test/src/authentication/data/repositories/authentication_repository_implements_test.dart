import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_tdd_bloc/core/errors/exception.dart';
import 'package:learn_tdd_bloc/core/errors/failure.dart';
import 'package:learn_tdd_bloc/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:learn_tdd_bloc/src/authentication/data/repositories/authentication_repository_implementation.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSrc extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource remoteDataSource;
  late AuthenticationRepositoryImplementation repoImpl;
  setUp(() {
    remoteDataSource = MockAuthRemoteDataSrc();
    repoImpl = AuthenticationRepositoryImplementation(remoteDataSource);
  });

  const tException = APIException(
    message: "Unknown error occour",
    statusCode: 500,
  );
  group("createUser", () {
    const createdAt = "whatever.createdAt";
    const name = "whatever.createdAt";
    const avatar = "whatever.avatar";
    test(
      "should call the [RemoteDataSource.createUser] and complete successfully when "
      "the call to the remote source is successfully",
      () async {
        // Arrange
        when(
          () => remoteDataSource.createUser(
            createdAt: any(named: "createdAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar"),
          ),
        ).thenAnswer((_) async {
          return Future.value();
        });

        // Act
        final result = await repoImpl.createUser(
          createdAt: createdAt,
          name: name,
          avatar: avatar,
        );

        // Assert
        expect(result, equals(const Right(null)));
        verify(
          () => remoteDataSource.createUser(
            createdAt: createdAt,
            name: name,
            avatar: avatar,
          ),
        );

        verifyNoMoreInteractions(remoteDataSource);
      },
    );

    test(
      'should return a [APIFailure] when the call to the remote source is unsuccessfull',
      () async {
        // Arrange
        when(
          () => remoteDataSource.createUser(
            createdAt: any(named: "createdAt"),
            name: any(named: "name"),
            avatar: any(named: "avatar"),
          ),
        ).thenThrow(tException);
        // Act
        final result = await repoImpl.createUser(
            createdAt: createdAt, name: name, avatar: avatar);

        // Assert
        expect(
          result,
          equals(
            Left(
              APIFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );

        verify(
          () => remoteDataSource.createUser(
              createdAt: createdAt, name: name, avatar: avatar),
        );

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });

  group("getUsers", () {
    test(
        "should call the [RemoteDataSource.getUser] "
        "and return the [List<User>] when the call "
        "is successful", () async {
      // Arrange
      when(
        () => remoteDataSource.getUsers(),
      ).thenAnswer((_) async {
        return [];
      });
      // Act
      final result = await repoImpl.getUsers();

      // Assert
      expect(result, isA<Right<dynamic, List<User>>>());

      verify(
        () => remoteDataSource.getUsers(),
      ).called(1);

      verifyNoMoreInteractions(remoteDataSource);
    });

    test(
      'should return a [APIFailure] when the call to the remote source is unsuccessfull',
      () async {
        // Arrange
        when(
          () => remoteDataSource.getUsers(),
        ).thenThrow(tException);
        // Act
        final result = await repoImpl.getUsers();

        // Assert
        expect(
          result,
          Left(
            APIFailure.fromException(tException),
          ),
        );
        verify(
          () => remoteDataSource.getUsers(),
        ).called(1);

        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
