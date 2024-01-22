import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/usecases/create_user.dart';
import 'package:mocktail/mocktail.dart';

import 'user_repository.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const params = CreateUserParams.empty();
  test("should call the [AuthRepo.createUser]", () async {
    //** ARRANGE */
    // SETUB
    when(
      () => repository.createUser(
        createdAt: any(named: "createdAt"),
        name: any(named: "name"),
        avatar: any(named: "avatar"),
      ),
      //**
      // THEN RETURN DIGUNAKAN UNTUK FUNCTION
      // YANG TIDAK ASYNC
      // */
      //**
      // THEN ANSWER DIGUNAKAN UNTUK FUNCTION
      // YANG ASYNC */
    ).thenAnswer((_) async => const Right(null));

    //** ACT */
    final result = await usecase(params);

    //** ASSERT */
    expect(result, equals(const Right<dynamic, void>(null)));

    verify(
      () => repository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      ),
    ).called(1);

    //**
    // TIDAK ADA INTERAKSI LAGI
    // KEAMANAN
    // */
    verifyNoMoreInteractions(repository);
  });
}
