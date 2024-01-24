part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserEvent({
    required this.createdAt,
    required this.avatar,
    required this.name,
  });

  @override
  List<Object> get props => [
        createdAt,
        avatar,
        name,
      ];
}

class GetUserEvent extends AuthenticationEvent {
  const GetUserEvent();
}
