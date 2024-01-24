import 'dart:convert';

import 'package:learn_tdd_bloc/core/errors/exception.dart';
import 'package:learn_tdd_bloc/core/utils/constants.dart';
import 'package:learn_tdd_bloc/core/utils/typedef.dart';
import 'package:learn_tdd_bloc/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  });

  Future<List<UserModel>> getUsers();
}

const kUserEndPoint = "/test-api/users";

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  final http.Client _client;

  const AuthRemoteDataSrcImpl(this._client);

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    //**
    // 1. check to make sure that it returns right data when
    // the status code is 200 or the proper response code
    // 2. check to make sure that it "THROWS A CUSTOM EXCEPTION"
    // with the right message when status code is the bad one*/

    try {
      final response = await _client.post(
          Uri.https(
            kBaseUrl,
            kUserEndPoint,
          ),
          body: jsonEncode({
            'createdAt': createdAt,
            'name': name,
            'avatar': avatar,
          }));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.https(
          kBaseUrl,
          kUserEndPoint,
        ),
      );
      if (response.statusCode != 200) {
        throw APIException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      List body = jsonDecode(response.body);
      List<DataMap> listMap = List<DataMap>.from(body).toList();
      List<UserModel> listUser =
          listMap.map((e) => UserModel.fromMap(e)).toList();
      return listUser;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }
}
