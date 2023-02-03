import 'package:json_annotation/json_annotation.dart';

part 'course_dao.g.dart';

@JsonSerializable()
class CourseDAO {
  String teacher_id;
  String course_id;
  String university;
  String present_code;
  String name;
  String student_count;
  String term;
  String group;
  String level;
  String status;

  CourseDAO({
    required this.teacher_id,
    required this.course_id,
    required this.university,
    required this.present_code,
    required this.name,
    required this.student_count,
    required this.term,
    required this.group,
    required this.level,
    required this.status,
  });
  factory CourseDAO.fromJson(Map<String, dynamic> json) =>
      _$CourseDAOFromJson(json);
  Map<String, dynamic> toJson() => _$CourseDAOToJson(this);
}
