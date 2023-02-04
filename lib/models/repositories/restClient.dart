import 'package:presence_absence/consts/url_const.dart';
import 'package:presence_absence/models/dao/course_dao.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../dao/session_dao.dart';

part 'restClient.g.dart';

@RestApi(baseUrl: basicUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {required String baseUrl}) = _RestClient;

  @GET(courseURL)
  Future<List<CourseDAO>> getCourses();
  @POST(courseURL)
  Future<void> updateCourse({
    @Part(name: "teacher_id") String teacherId,
    @Part(name: "course_id") String courseId,
    @Part(name: "university") String universityId,
    @Part(name: "present_code") String presentCode,
    @Part(name: "name") String courseName,
    @Part(name: "student_count") String studentCount,
    @Part(name: "term") String term,
    @Part(name: "group") String group,
    @Part(name: "level") String level,
    @Part(name: "status") String status,
  });

  @GET(sessionURL)
  Future<List<SessionDAO>> getSessions();
  @POST(sessionURL)
  Future<void> updateSessions(
      {@Part(name: "id") String id,
      @Part(name: "course_id") String courseID,
      @Part(name: "status") String status,
      @Part(name: "comment") String comment});
}
