import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/bloc/attendances_bloc.dart';
import 'package:presence_absence/consts/url_const.dart';
import 'package:presence_absence/models/repositories/restClient.dart';

import '../bloc/course_bloc.dart';
import '../bloc/universities_bloc.dart';
import '../bloc/users_bloc.dart';
import '../models/attendacne.dart';
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
    var dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["Authorization"] = "Bearer ${user.auth}";
    context
        .read<RetrofitProvider>()
        .newClient(RestClient(dio, baseUrl: basicUrl));
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

Future getInfoForAttendance({
  required BuildContext context,
  required RestClient rest,
  required UniversitiesBloc universitiesBloc,
  required CourseBloc courseBloc,
  required AttendacneRepo attendacneRepo,
}) async {
  try {
    var universities = await rest.getUniversities();
    var list = universities;
    universitiesBloc.newUniversities(list);
    var courses = await rest.getCourses();

    courseBloc.newCourses(courses);
    var session = await rest.getSessions();

    var attendanceList = session.map((se) {
      var course =
          courses.firstWhere((element) => element.course_id == se.course_id);
      return Attendance(
          className: course.name,
          teacherName: course.teacher_id,
          uniName: course.university,
          sessionId: se.id,
          numberOfStudent: course.student_count,
          classNumber: course.present_code);
    }).toList();

    attendacneRepo.replace(attendanceList);
  } catch (e) {
    var res = (e as DioError).response;
    print(res?.toString());
  }

  return Future.value();
}
