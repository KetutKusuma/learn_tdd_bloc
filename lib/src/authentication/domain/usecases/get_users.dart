import 'package:learn_tdd_bloc/core/usecase/usecase.dart';
import 'package:learn_tdd_bloc/core/utils/typedef.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/entities/user.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParam<List<User>> {
  final AuthenticationRepository _authenticationRepository;

  const GetUsers(this._authenticationRepository);

  @override
  ResultFuture<List<User>> call() async => _authenticationRepository.getUsers();
}
