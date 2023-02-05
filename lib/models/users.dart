import 'package:flutter/material.dart';
import 'package:presence_absence/models/roles.dart';
import 'package:presence_absence/routes.dart';

class Users {
  final String id;
  final String username;
  final String password;
  final String auth;
  final Role role;

  Users(
      {required this.id,
      required this.username,
      required this.password,
      required this.auth,
      required this.role});
  Users.def()
      : this(
            id: "",
            auth: "jjjj",
            password: "",
            role: Role.admin,
            username: "Ahmadi");

  Users copyWith({
    String? id,
    String? username,
    String? password,
    String? auth,
    Role? role,
  }) {
    return Users(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      auth: auth ?? this.auth,
      role: role ?? this.role,
    );
  }

  bool checkUserValidation() {
    return auth.isNotEmpty;
  }

  void doUserValidation(BuildContext context) {
    if (!checkUserValidation()) {
      RouteGenerator.goTo(context: context, Routes.logIn);
    }
  }

  @override
  String toString() {
    return 'Users{id: $id, username: $username, password: $password, auth: $auth, role: $role}';
  }
}
