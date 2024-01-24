import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:learn_tdd_bloc/core/utils/typedef.dart';
import 'package:learn_tdd_bloc/src/authentication/data/models/user_model.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();

  test("should be subclass of [User] entity", () {
    // Arrange

    // Act
    //* NO ACT*/
    // Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture("user.json");
  final tMap = jsonDecode(tJson) as DataMap;

  group("fromMap", () {
    test("should be return a [UserModel] with right data from map", () {
      // Arrange
      // Sudah diatas
      // Act
      final result = UserModel.fromMap(tMap);
      // Assert
      expect(result, equals(tModel));
    });
  });

  group("fromJson", () {
    // Arrange
    test("should be return a [UserModel] with right data from json", () {
      // Arrange
      // Sudah diatas
      // Act
      final result = UserModel.fromJson(tJson);
      // Assert
      expect(result, equals(tModel));
    });
  });

  group("toMap", () {
    test("sholud be return  a [Map] with right data UserModel", () {
      // Arrange
      // Act
      final result = tModel.toMap();
      // Assert
      expect(result, equals(tMap));
    });
  });

  group("toJson", () {
    test("should be retrun a [JSON] with right data UserModel", () {
      // Arrange
      // Act
      final result = tModel.toJson();
      // Assert
      final tJsonU = jsonEncode({
        "id": "1",
        "avatar": "empty.avatar",
        "name": "empty.name",
        "createdAt": "empty.createdAt"
      });
      expect(result, equals(tJsonU));
    });
  });

  group("copyWith", () {
    test(
      "should be return a [UserModel] with updated data",
      () {
        // Arrange
        // Act
        final result = tModel.copyWith(name: 'Uhuy');
        // Assert
        expect(result.name, equals("Uhuy"));
        expect(result, isNot(tModel));
      },
    );
  });
}
