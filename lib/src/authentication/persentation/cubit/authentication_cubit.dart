import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/usecases/create_user.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/usecases/get_users.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(
          const AuthenticationInitial(),
        );

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUsers({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    emit(const CreatingUser());

    final result = await _createUser(
      CreateUserParams(
        createdAt: createdAt,
        avatar: avatar,
        name: name,
      ),
    );

    result.fold(
        (lFailure) => emit(
              AuthenticationError(
                lFailure.errorMessage,
              ),
            ),
        (_) => emit(const UserCreated()));
  }

  Future<void> getUsers() async {
    emit(
      const GettingUser(),
    );

    final result = await _getUsers();

    result.fold(
      (lFailure) => emit(
        AuthenticationError(
          lFailure.errorMessage,
        ),
      ),
      (rUsers) => emit(
        UserLoaded(rUsers),
      ),
    );
  }
}
