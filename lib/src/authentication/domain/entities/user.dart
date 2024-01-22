import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const User.empty()
      : this(
          id: "1",
          createdAt: "empty.createdAt",
          name: "empty.name",
          avatar: "empty.avatar",
        );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, avatar];
}
