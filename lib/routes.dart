import 'package:flutter/material.dart';
import 'package:presence_absence/routes/attendance_page.dart';
import 'package:presence_absence/routes/log_in_page.dart';
import 'package:presence_absence/routes/portal_page.dart';
import 'package:presence_absence/routes/session_attendance_page.dart';

class RouteGenerator {
  static const String login = "/";
  static const String attendance = "/attendance";
  static const String sesstionAattendacne = "/attendance/session";
  static const String portalPage = "/portal";
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case attendance:
        {
          return MaterialPageRoute(builder: (_) => const AttendancePage());
        }
      case sesstionAattendacne:
        {
          return MaterialPageRoute(builder: (_) => const SessionPage());
        }
      case portalPage:
        {
          return MaterialPageRoute(builder: (_) => const PortalPage());
        }
      default:
        {
          return MaterialPageRoute(builder: (_) => const LoginPage());
        }
    }
  }

  static void goTo(Routes route,
      {BuildContext? context, bool replace = false}) {
    BuildContext myContext = context ?? navigatorKey.currentContext!;
    String myRoute;
    switch (route) {
      case Routes.logIn:
        myRoute = RouteGenerator.login;
        break;
      case Routes.attendance:
        myRoute = RouteGenerator.attendance;
        break;
      case Routes.session:
        myRoute = RouteGenerator.sesstionAattendacne;
        break;
      case Routes.portal:
        myRoute = RouteGenerator.portalPage;
        break;
    }
    if (replace) {
      Navigator.pushReplacementNamed(myContext, myRoute);
    } else {
      Navigator.pushNamed(myContext, myRoute);
    }
  }
}

enum Routes {
  logIn,
  attendance,
  session,
  portal;
}
