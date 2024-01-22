import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/usecases/get_users.dart';
import 'package:mocktail/mocktail.dart';

import 'user_repository.mock.dart';

void main() {
  late AuthenticationRepository repository;
  late GetUsers usecases;

  setUp(() {
    repository = MockAuthRepo();
    usecases = GetUsers(repository);
  });

  const tResponse = [
    User.empty(),
  ];

  test("Should call [AuthRepo.getUsers] and return [List<User>]", () async {
    // ARRANGE
    when(
      () => repository.getUsers(),
    ).thenAnswer((_) async {
      return const Right(tResponse);
    });

    // ACT
    final result = await usecases();

    // ASSERT
    expect(result, equals(const Right<dynamic, List<User>>(tResponse)));

    verify(
      () => repository.getUsers(),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
