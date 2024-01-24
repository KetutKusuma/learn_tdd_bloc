import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learn_tdd_bloc/core/errors/failure.dart';
// import 'package:learn_tdd_bloc/src/authentication/data/models/user_model.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/usecases/create_user.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/usecases/get_users.dart';
import 'package:learn_tdd_bloc/src/authentication/persentation/cubit/authentication_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit authenticationCubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tAPIFailure = APIFailure(
    message: "message",
    statusCode: 400,
  );
  // const tUsers = [UserModel.empty()];

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    authenticationCubit = AuthenticationCubit(
      createUser: createUser,
      getUsers: getUsers,
    );
    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => authenticationCubit.close());

  test("initial state should be [AuthenticationInitial]", () {
    // assert
    expect(
      authenticationCubit.state,
      const AuthenticationInitial(),
    );
  });

  group("createUser", () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      "should emit [CreatingUser, UserCreated] when successful",
      build: () {
        when(
          () => createUser(any()),
        ).thenAnswer(
          (_) async => const Right(null),
        );

        return authenticationCubit;
      },
      // act di bloc berbeda
      // ini act di cubit
      act: (cubit) {
        cubit.createUsers(
          createdAt: tCreateUserParams.createdAt,
          name: tCreateUserParams.name,
          avatar: tCreateUserParams.avatar,
        );
      },
      expect: () {
        return [
          const CreatingUser(),
          const UserCreated(),
        ];
      },
      verify: (_) {
        verify(
          () => createUser(tCreateUserParams),
        );
        verifyNoMoreInteractions(createUser);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      "should emit [CreatingUser, AuthenticationError] when createUser is unsuccessful",
      build: () {
        when(
          () => createUser(any()),
        ).thenAnswer(
          (_) async => const Left(
            tAPIFailure,
          ),
        );

        return authenticationCubit;
      },
      act: (cubit) => cubit.createUsers(
        createdAt: tCreateUserParams.createdAt,
        name: tCreateUserParams.name,
        avatar: tCreateUserParams.avatar,
      ),
      expect: () => [
        const CreatingUser(),
        AuthenticationError(
          tAPIFailure.errorMessage,
        ),
      ],
      verify: (_) {
        verify(
          () => createUser(tCreateUserParams),
        );
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  group("getUsers", () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [GettingUsers, Userloaded] when getUsers is successfull.',
      build: () {
        when(
          () => getUsers(),
        ).thenAnswer((_) async => const Right([]));
        return authenticationCubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => const [
        GettingUsers(),
        UserLoaded(
          [],
        )
      ],
      verify: (_) {
        verify(
          () => getUsers(),
        ).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );

    blocTest<AuthenticationCubit, AuthenticationState>(
      'emits [GettingUsers, AuthenticationError] when getUsers is unsuccessful.',
      build: () {
        when(
          () => getUsers(),
        ).thenAnswer((_) async => const Left(tAPIFailure));
        return authenticationCubit;
      },
      act: (cubit) => cubit.getUsers(),
      expect: () => [
        const GettingUsers(),
        AuthenticationError(
          tAPIFailure.errorMessage,
        ),
      ],
      verify: (_) {
        verify(
          () => getUsers(),
        ).called(1);
        verifyNoMoreInteractions(getUsers);
      },
    );
  });
}
