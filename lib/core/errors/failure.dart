import 'package:equatable/equatable.dart';
import 'package:learn_tdd_bloc/core/errors/exception.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  String get errorMessage => "$statusCode Error : $message";

  const Failure({
    required this.message,
    required this.statusCode,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [message, statusCode];
}

class APIFailure extends Failure {
  const APIFailure({
    required super.message,
    required super.statusCode,
  });

  APIFailure.fromException(APIException apiException)
      : this(
          message: apiException.message,
          statusCode: apiException.statusCode,
        );
}
