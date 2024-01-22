import 'dart:convert';

import 'package:learn_tdd_bloc/core/utils/typedef.dart';
import 'package:learn_tdd_bloc/src/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.avatar,
    required super.name,
    required super.createdAt,
  });

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'],
          createdAt: map['createdAt'],
          name: map['name'],
          avatar: map['avatar'],
        );

  factory UserModel.fromJson(String source) => UserModel.fromMap(
        jsonDecode(source),
      );

  DataMap toMap() => {
        "id": id,
        "avatar": avatar,
        "name": name,
        "createdAt": createdAt,
      };

  String toJson() => jsonEncode(toMap());

  UserModel copyWith({
    String? avatar,
    String? name,
    String? createdat,
    String? id,
  }) {
    return UserModel(
      id: id ?? this.id,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      createdAt: createdat ?? createdAt,
    );
  }

  const UserModel.empty()
      : this(
          id: "1",
          createdAt: "empty.createdAt",
          name: "empty.name",
          avatar: "empty.avatar",
        );
}
