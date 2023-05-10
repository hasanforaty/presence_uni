import 'package:json_annotation/json_annotation.dart';

part 'course_dao.g.dart';

@JsonSerializable()
class CourseDAO {
  int id;
  int? teacher_id;
  int course_id;
  int location_id;
  String name;
  int students_count;
  int term_id;
  String group;
  String level;
  String status;

  factory CourseDAO.fromJson(Map<String, dynamic> json) =>
      _$CourseDAOFromJson(json);
  Map<String, dynamic> toJson() => _$CourseDAOToJson(this);

  CourseDAO({
    required this.id,
    required this.teacher_id,
    required this.course_id,
    required this.location_id,
    required this.name,
    required this.students_count,
    required this.term_id,
    required this.group,
    required this.level,
    required this.status,
  });
}

@JsonSerializable()
class CoursesDAO {
  List<CourseDAO> data;

  CoursesDAO({
    required this.data,
  });

  factory CoursesDAO.fromJson(Map<String, dynamic> json) =>
      _$CoursesDAOFromJson(json);
  Map<String, dynamic> toJson() => _$CoursesDAOToJson(this);
}
