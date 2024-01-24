import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/usecases/create_user.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/usecases/get_users.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    // on<GetUserEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
    CreateUserEvent createUserEvent,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const CreatingUser());

    final result = await _createUser(
      CreateUserParams(
        createdAt: createUserEvent.createdAt,
        avatar: createUserEvent.avatar,
        name: createUserEvent.name,
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

  Future<void> _getUsersHandler(
    GetUserEvent getUserEvent,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(
      const GettingUsers(),
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
