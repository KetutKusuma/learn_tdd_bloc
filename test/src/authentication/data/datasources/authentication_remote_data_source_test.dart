import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:learn_tdd_bloc/core/errors/exception.dart';
import 'package:learn_tdd_bloc/core/utils/constants.dart';
import 'package:learn_tdd_bloc/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:learn_tdd_bloc/src/authentication/data/models/user_model.dart';
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockClient();
    remoteDataSource = AuthRemoteDataSrcImpl(client);
    //** KARENA URL ITU TIPENYA BUKAN STRING
    // MAKA HARUS DIREGISTER DULU TIPE DATANYA
    // YAITU URI */
    registerFallbackValue(Uri());
  });

  group("createUser", () {
    test(
      "should complete successfully when the status code is 200 or 201",
      () async {
        // Arrange
        when(
          () => client.post(
            any(),
            body: any(named: "body"),
            headers: {
              'Content-type': 'application-json',
            },
          ),
        ).thenAnswer(
          (_) async => http.Response(
            "User created successfully",
            201,
          ),
        );
        // Act
        final methodCall = remoteDataSource.createUser;

        // Assert
        expect(
          /// TOP ORDER
          methodCall(
            createdAt: 'createdAt',
            avatar: 'avatar',
            name: 'name',
          ),
          completes,
        );

        verify(
          () => client.post(
            Uri.https(kBaseUrl, kUserEndPoint),
            body: jsonEncode(
              {
                "createdAt": "createdAt",
                "name": "name",
                "avatar": "avatar",
              },
            ),
            headers: {
              'Content-type': 'application-json',
            },
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test(
      "should throw [APIException] when the status code is not 200 or 201",
      () async {
        // Arrange

        when(
          () => client.post(
            any(),
            body: any(named: "body"),
            headers: {
              'Content-type': 'application-json',
            },
          ),
        ).thenAnswer(
          (_) async => http.Response("Invalid Email Address", 400),
        );

        // Act
        final methodCall = remoteDataSource.createUser;

        // Assert
        expect(
          () async => methodCall(
            avatar: 'avatar',
            name: 'name',
            createdAt: 'createdAt',
          ),
          throwsA(const APIException(
              message: "Invalid Email Address", statusCode: 400)),
        );

        verify(
          () => client.post(
            Uri.https(
              kBaseUrl,
              kUserEndPoint,
            ),
            body: jsonEncode(
              {
                'createdAt': 'createdAt',
                'name': 'name',
                'avatar': 'avatar',
              },
            ),
            headers: {
              'Content-type': 'application-json',
            },
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );
  });

  group("getUsers", () {
    final tUsers = [
      const UserModel.empty(),
    ];
    test(
      "sholud return a [List<User>] when the response status code is 200",
      () async {
        // arrange
        when(
          () => client.get(any()),
        ).thenAnswer(
          (_) async => http.Response(
            jsonEncode([tUsers.first.toMap()]),
            200,
          ),
        );

        // act
        final result = await remoteDataSource.getUsers();

        // assert
        expect(
          result,
          equals(tUsers),
        );

        verify(
          () => client.get(
            Uri.https(kBaseUrl, kUserEndPoint),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test("should return [APIException] when the response code is not 200",
        () async {
      // arrange
      when(
        () => client.get(any()),
      ).thenAnswer(
        (_) async => http.Response(
          "Server down",
          500,
        ),
      );

      // act
      final methodCall = remoteDataSource.getUsers;

      // assert

      expect(
          () => methodCall(),
          throwsA(
            const APIException(
              message: "Server down",
              statusCode: 500,
            ),
          ));

      verify(
        () => client.get(
          Uri.https(kBaseUrl, kUserEndPoint),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
