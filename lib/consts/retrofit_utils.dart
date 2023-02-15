import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/bloc/attendances_bloc.dart';
import 'package:presence_absence/consts/consts.dart';
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
    required BuildContext context,
    required void Function() onFinished}) async {
  try {
    var rest = context.read<RetrofitProvider>();
    var loginBloc = context.read<UserBloc>();

    var userDao =
        await rest.state.login(userName, password, "application/json");
    var user = userDao.data!.toUsers();

    loginBloc.changeUsers(user);
    var dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    dio.options.headers["Authorization"] = "Bearer ${user.auth}";
    dio.interceptors.add(myInternetIntercepter);
    context
        .read<RetrofitProvider>()
        .newClient(RestClient(dio, baseUrl: basicUrl));
    onFinished();
    if (user.role == Role.admin) {
      // Navigator.pop(context);
      print("reach rule admin");
      RouteGenerator.goTo(Routes.portal, context: context, replace: true);
    } else {
      print("reach rule other");
      RouteGenerator.goTo(Routes.attendance, context: context, replace: true);
    }
  } on Exception catch (e) {
    print(e);
    onFinished();
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
    universitiesBloc.newUniversities(list.data!.data);
    var courses = await rest.getCourses();

    courseBloc.newCourses(courses.data!.data);
    var session = await rest.getSessions();
    var teachers = await rest.getTeachers();
    var locations = await rest.getLocations();
    var attendanceList = session.data?.data.map((se) {
      var course = courses.data!.data
          .firstWhere((element) => element.id == se.course_id);

      var teacher = teachers.data!.data
          .firstWhere((element) => element.id == course.teacher_id);
      var location = locations.data!.data
          .firstWhere((element) => element.id == course.location_id);
      var uni = list.data!.data
          .firstWhere((element) => element.id == location.university_id);
      AttendanceStatus status = AttendanceStatus.unDecided;
      if (se.status == null) status = AttendanceStatus.unDecided;
      if ((se.status ?? "") == "absent") status = AttendanceStatus.absent;
      if ((se.status ?? "") == "present") status = AttendanceStatus.present;
      return Attendance(
        className: course.name,
        teacherName: "${teacher.name} ${teacher.last_name}",
        uniName: uni.name,
        sessionId: se.id,
        numberOfStudent: course.students_count.toString(),
        classNumber: location.class_number.toString(),
        status: status,
        comment: se.comment,
      );
    }).toList();

    attendacneRepo.replace(attendanceList!);
  } on Exception catch (e) {
    print(e);
    if (e is DioError) {
      return Future.value();
    }
    await Future.delayed(const Duration(seconds: 2));
    var message = "مشکلی در ساختار برنامه رخ داده";
    ScaffoldMessenger.of(RouteGenerator.navigatorKey.currentContext!)
        .showSnackBar(
      SnackBar(
        content: Text(
          message,
          textDirection: TextDirection.rtl,
          style: Theme.of(RouteGenerator.navigatorKey.currentContext!)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  return Future.value();
}

Future sendSessionUpdate({
  required BuildContext context,
  required RestClient rest,
  required bool present,
  required String comment,
  required int sessionId,
}) async {
  try {
    var commentKey = "comment";
    var statusKey = "status";
    await rest.updateSessions(sessionId,
        {commentKey: comment, statusKey: present ? "present" : "absent"});
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "تغیرات اعمال شد",
        textDirection: TextDirection.rtl,
      ),
      duration: Duration(seconds: 3),
    ));
    await Future.delayed(const Duration(seconds: 3));
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text(
        "تغیرات اعمال نشد",
        textDirection: TextDirection.rtl,
      ),
      duration: Duration(seconds: 1),
    ));
    await Future.delayed(const Duration(seconds: 1));
  }

  Navigator.of(context).pop();

  return Future.value();
}

Future updateFile(
    {required BuildContext context,
    required RestClient rest,
    required String path}) async {
  try {
    File file = File(path);
    await rest.uploadFile(file);
  } on Exception catch (e) {
    print(e);
  }

  return Future.value();
}
