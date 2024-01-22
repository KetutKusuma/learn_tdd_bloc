import 'package:equatable/equatable.dart';
import 'package:learn_tdd_bloc/core/usecase/usecase.dart';
import 'package:learn_tdd_bloc/core/utils/typedef.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParam<void, CreateUserParams> {
  final AuthenticationRepository _authenticationRepository;

  const CreateUser(this._authenticationRepository);

  // ResultVoid createUser({
  //   required String created,
  //   required String name,
  //   required String avatar,
  // }) async =>

  @override
  ResultVoid call(CreateUserParams params) async =>
      _authenticationRepository.createUser(
        createdAt: params.createdAt,
        name: params.name,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  final String createdAt, name, avatar;

  const CreateUserParams({
    required this.createdAt,
    required this.avatar,
    required this.name,
  });

  const CreateUserParams.empty()
      : this(
          createdAt: "_empty.createdAt",
          name: "_empty.name",
          avatar: '_empty.avatar',
        );

  @override
  // TODO: implement props
  List<Object?> get props => [createdAt, name, avatar];
}
