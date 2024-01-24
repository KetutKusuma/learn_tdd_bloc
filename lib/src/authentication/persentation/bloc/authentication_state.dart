part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

class GettingUser extends AuthenticationState {
  const GettingUser();
}

class UserCreated extends AuthenticationState {
  const UserCreated();
}

class UserLoaded extends AuthenticationState {
  final List<User> users;

  const UserLoaded(this.users);

  @override
  // TODO: implement props
  List<Object> get props => users.map((e) => e.id).toList();
}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);

  @override
  // TODO: implement props
  List<Object> get props => [message];
}
