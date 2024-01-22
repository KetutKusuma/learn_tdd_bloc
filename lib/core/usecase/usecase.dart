import 'package:learn_tdd_bloc/core/utils/typedef.dart';

abstract class UsecaseWithParam<Type, Params> {
  const UsecaseWithParam();
  ResultFuture<Type> call(Params params);
}

abstract class UsecaseWithoutParam<Type> {
  const UsecaseWithoutParam();
  ResultFuture<Type> call();
}
