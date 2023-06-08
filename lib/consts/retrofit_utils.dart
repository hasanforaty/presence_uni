import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/bloc/attendances_bloc.dart';
import 'package:presence_absence/bloc/users_bloc.dart';
import 'package:presence_absence/consts/consts.dart';
import 'package:presence_absence/consts/url_const.dart';
import 'package:presence_absence/models/dao/course_dao.dart';
import 'package:presence_absence/models/dao/location_dao.dart';
import 'package:presence_absence/models/dao/session_dao.dart';
import 'package:presence_absence/models/dao/teacher_dao.dart';
import 'package:presence_absence/models/dao/university_dao.dart';
import 'package:presence_absence/models/dao/users_dao.dart';
import 'package:presence_absence/models/repositories/restClient.dart';
import 'package:presence_absence/models/users.dart';

import '../bloc/course_bloc.dart';
import '../bloc/universities_bloc.dart';
import '../bloc/user_bloc.dart';
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
    var session = (await rest.getSessions()).data!.data.toList();
    var teachers = await rest.getTeachers();
    var locations = await rest.getLocations();
    //create new temporary session base on classes
    for (var cours in courses.data!.data) {
      var se = session.where((element) => element.course_id == cours.course_id);
      if (se.isEmpty) {
        session.add(SessionDAO(
            course_id: cours.course_id,
            location_id: cours.location_id,
            time: cours.times,
            status: null,
            comment: null));
      }
    }

    var attendanceList = <Attendance>[];
    for (var se in session) {
      print(se.toJson());
      try {
        var course = courses.data!.data.firstWhere((element) {
          return element.course_id == se.course_id;
        });
        var teacher = course.teacher_id == null
            ? TeacherDao(id: 0, name: "نامشخص", last_name: "", national_code: 0)
            : teachers.data!.data.firstWhere(
                (element) => element.id == course.teacher_id,
                orElse: () => TeacherDao(
                    id: 0, name: "نامشخص", last_name: "", national_code: 0));

        var location = locations.data?.data.firstWhere(
            (element) => element.id == course.location_id,
            orElse: () => LocationDao(
                id: -1, university_id: -1, class_number: -1, floor: -1));

        var uni = list.data!.data.firstWhere(
            (element) => element.id == location?.university_id,
            orElse: () => UniversityDao(id: -1, name: 'نامشخص'));
        AttendanceStatus status = AttendanceStatus.unDecided;
        if (se.status == null) status = AttendanceStatus.unDecided;
        if ((se.status ?? "") == "absent") status = AttendanceStatus.absent;
        if ((se.status ?? "") == "present") status = AttendanceStatus.present;
        var attendance = Attendance(
            className: course.name,
            teacherName: "${teacher.name} ${teacher.last_name}",
            uniName: uni.name,
            sessionId: se.id,
            numberOfStudent: course.students_count.toString(),
            classNumber: location?.class_number.toString() ?? "",
            status: status,
            comment: se.comment,
            locaitonId: se.location_id,
            courseId: se.course_id,
            times: se.time);
        attendanceList.add(attendance);
        print("attendance is added");
      } catch (e) {}
    }
    print("we are out");
    attendacneRepo.replace(attendanceList);
  } catch (e) {
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
    await Future.delayed(const Duration(seconds: 2));
    return Future.value();
  }

  return Future.value();
}

Future sendSessionUpdate({
  required BuildContext context,
  required RestClient rest,
  required bool present,
  required String comment,
  required int? sessionId,
  required Attendance attendance,
  required String? times,
}) async {
  try {
    var commentKey = "comment";
    var statusKey = "status";
    var timeKey = "time";
    if (sessionId == null) {
      await rest.createSession({
        commentKey: comment,
        statusKey: present ? "present" : "absent",
        "location_id": attendance.locaitonId.toString(),
        "course_id": attendance.courseId.toString(),
        timeKey: times
      });
    } else {
      await rest.updateSessions(sessionId,
          {commentKey: comment, statusKey: present ? "present" : "absent"});
    }
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

Future getUsers(
    {required BuildContext context, required RestClient rest}) async {
  var usersBloc = context.read<UsersBloc>();
  print("trying to get users");
  var usersData = await rest.getUsers();
  print("Got user");
  usersBloc.change(usersData.data!.data);
  return Future.value();
}

Future changeUserRole(
    {required RestClient rest, required int userId, required String role}) {
  String roleId = "role";
  rest.changeUser(userId, {roleId: role});
  return Future.value();
}

Future signUp(
    {required RestClient rest,
    required String username,
    required String password,
    required String role,
    required name}) {
  String roleId = "role";
  String nameId = "name";
  String passwordId = "password";
  String confirmPasswordId = "confirm_password";
  String emailId = "email";
  rest.signUp({
    roleId: role,
    passwordId: password,
    emailId: username,
    confirmPasswordId: password,
    nameId: name,
  });
  return Future.value();
}
