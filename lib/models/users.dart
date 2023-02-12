import 'package:flutter/material.dart';
import 'package:presence_absence/models/roles.dart';
import 'package:presence_absence/routes.dart';

class Users {
  final int id;
  final String username;

  final String auth;
  final Role role;

  Users(
      {required this.id,
      required this.username,
      required this.auth,
      required this.role});
  Users.def() : this(id: 0, auth: "jjjj", role: Role.admin, username: "Ahmadi");

  Users copyWith({
    int? id,
    String? username,
    String? auth,
    Role? role,
  }) {
    return Users(
      id: id ?? this.id,
      username: username ?? this.username,
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
    return 'Users{id: $id, username: $username, auth: $auth, role: $role}';
  }
}
