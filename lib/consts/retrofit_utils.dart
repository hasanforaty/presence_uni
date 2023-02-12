import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/users_bloc.dart';
import '../models/providers/retrofit_provider.dart';
import '../models/roles.dart';
import '../routes.dart';

Future logIn(
    {required String userName,
    required String password,
    required BuildContext context}) async {
  try {
    var rest = context.read<RetrofitProvider>();
    var loginBloc = context.read<UserBloc>();

    var userDao =
        await rest.state.login(userName, password, "application/json");
    var user = userDao.toUsers();

    loginBloc.changeUsers(user);

    if (user.role == Role.admin) {
      // Navigator.pop(context);
      RouteGenerator.goTo(Routes.portal,
          context: RouteGenerator.navigatorKey.currentContext!, replace: true);
    } else {
      RouteGenerator.goTo(Routes.attendance, context: context, replace: true);
    }
  } catch (e) {
    var res = (e as DioError).response;
    print(res?.toString());
  }
}
