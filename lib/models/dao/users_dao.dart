import 'package:presence_absence/models/roles.dart';
import 'package:presence_absence/models/users.dart';
import 'package:json_annotation/json_annotation.dart';
part 'users_dao.g.dart';

@JsonSerializable()
class UserDao {
  final String token;
  final UserDaoData user;

  const UserDao({
    required this.token,
    required this.user,
  });
  Users toUsers() => Users(
      id: user.id,
      username: user.username,
      auth: token,
      role: user.role == "controller" ? Role.others : Role.admin);
  factory UserDao.fromJson(Map<String, dynamic> json) =>
      _$UserDaoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDaoToJson(this);
}

@JsonSerializable()
class UserDaoData {
  int id;
  String name;
  String email;
  String username;
  String role;
  UserDaoData({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.role,
  });
  factory UserDaoData.fromJson(Map<String, dynamic> json) =>
      _$UserDaoDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDaoDataToJson(this);
}
