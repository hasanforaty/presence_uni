import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/bloc/selected_attendance_bloc.dart';
import 'package:presence_absence/consts/consts.dart';
import 'package:presence_absence/consts/url_const.dart';
import 'package:presence_absence/models/providers/drawer_controller_bloc.dart';
import 'package:presence_absence/models/providers/retrofit_provider.dart';
import 'package:presence_absence/models/repositories/restClient.dart';
import 'package:presence_absence/routes.dart';
import 'package:dio/dio.dart';

import 'bloc/attendacne_filter_bloc.dart';
import 'bloc/attendances_bloc.dart';
import 'bloc/course_bloc.dart';
import 'bloc/universities_bloc.dart';
import 'bloc/user_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SelectedAttendanceBloc>(
            create: (_) => SelectedAttendanceBloc()),
        BlocProvider<DrawerControllerBloc>(
            create: (_) => DrawerControllerBloc()),
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(),
        ),
        BlocProvider<RetrofitProvider>(create: (_) {
          var dio = Dio();
          dio.interceptors.add(myInternetIntercepter);
          dio.options.headers["Content-Type"] = "application/json";
          return RetrofitProvider(RestClient(dio, baseUrl: basicUrl));
        }),
        BlocProvider<AttendacneRepo>(create: (_) => AttendacneRepo()),
        BlocProvider<AttendanceFilterBloc>(
            create: (_) => AttendanceFilterBloc()),
        BlocProvider<UniversitiesBloc>(create: (_) => UniversitiesBloc()),
        BlocProvider<CourseBloc>(create: (_) => CourseBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        navigatorKey: RouteGenerator.navigatorKey,
        initialRoute: RouteGenerator.splashPage,
        scrollBehavior: const ConstantScrollBehavior(),
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          fontFamily: "vazir",
        ),
      ),
    );
  }
}

class ConstantScrollBehavior extends ScrollBehavior {
  const ConstantScrollBehavior();

  @override
  Widget buildScrollbar(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  Widget buildOverscrollIndicator(
          BuildContext context, Widget child, ScrollableDetails details) =>
      child;

  @override
  TargetPlatform getPlatform(BuildContext context) => TargetPlatform.macOS;

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());
}
