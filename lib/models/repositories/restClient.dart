import 'dart:io';

import 'package:presence_absence/consts/url_const.dart';
import 'package:presence_absence/models/dao/course_dao.dart';
import 'package:presence_absence/models/dao/location_dao.dart';
import 'package:presence_absence/models/dao/teacher_dao.dart';
import 'package:presence_absence/models/dao/university_dao.dart';
import 'package:presence_absence/models/dao/users_dao.dart';
import 'package:presence_absence/models/response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../dao/session_dao.dart';

part 'restClient.g.dart';

@RestApi(baseUrl: basicUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {required String baseUrl}) = _RestClient;

  @GET(courseURL)
  Future<BaseResponse<CoursesDAO>> getCourses();
  // @POST(courseURL)
  // Future<void> updateCourse({
  //   @Part(name: "teacher_id") String teacherId,
  //   @Part(name: "course_id") String courseId,
  //   @Part(name: "university") String universityId,
  //   @Part(name: "present_code") String presentCode,
  //   @Part(name: "name") String courseName,
  //   @Part(name: "student_count") String studentCount,
  //   @Part(name: "term") String term,
  //   @Part(name: "group") String group,
  //   @Part(name: "level") String level,
  //   @Part(name: "status") String status,
  // });

  @GET(sessionURL)
  Future<BaseResponse<SessionsDAO>> getSessions();

  @PUT("$sessionURL/{session_id}")
  Future<void> updateSessions(
      @Path() int session_id, @Body() Map<String, dynamic> map);

  @POST("$sessionURL")
  Future<void> createSession(@Body() Map<String, dynamic> map);

  @POST(loginURL)
  Future<BaseResponse<UserDao>> login(@Part(name: "email") userName,
      @Part(name: "password") password, @Header("Content-Type") String header);
  @GET(university)
  Future<BaseResponse<UniversitiesDao>> getUniversities();
  @GET(teacherURL)
  Future<BaseResponse<TeachersDao>> getTeachers();
  @GET(locationURL)
  Future<BaseResponse<LocationsDao>> getLocations();
  @POST(uploadURL)
  Future<void> uploadFile(@Part() File file);

  @GET(usersURL)
  Future<BaseResponse<UsersDao>> getUsers();
}
