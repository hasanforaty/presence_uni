import 'package:flutter/material.dart';
import 'package:presence_absence/routes/attendance_page.dart';
import 'package:presence_absence/routes/log_in_page.dart';

class RouteGenerator {
  static const String login = "/";
  static const String attendance = "/attendance";

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case attendance:
        {
          return MaterialPageRoute(builder: (_) => const AttendancePage());
        }
      default:
        {
          return MaterialPageRoute(builder: (_) => const LoginPage());
        }
    }
  }

  static void goTo(BuildContext context, Routes route) {
    String myRoute;
    switch (route) {
      case Routes.logIn:
        myRoute = RouteGenerator.login;
        break;
      case Routes.attendance:
        myRoute = RouteGenerator.attendance;
        break;
    }
    Navigator.pushNamed(context, myRoute);
  }
}

enum Routes {
  logIn,
  attendance;
}
