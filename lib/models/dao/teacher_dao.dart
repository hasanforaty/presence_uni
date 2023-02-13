import 'package:json_annotation/json_annotation.dart';

part 'teacher_dao.g.dart';

@JsonSerializable()
class TeacherDao {
  int id;
  String name;
  String last_name;

  TeacherDao({
    required this.id,
    required this.name,
    required this.last_name,
  });
  Map<String, dynamic> toJson() => _$TeacherDaoToJson(this);
  factory TeacherDao.fromJson(Map<String, dynamic> json) =>
      _$TeacherDaoFromJson(json);
}

@JsonSerializable()
class TeachersDao {
  List<TeacherDao> data;

  TeachersDao({
    required this.data,
  });
  Map<String, dynamic> toJson() => _$TeachersDaoToJson(this);
  factory TeachersDao.fromJson(Map<String, dynamic> json) =>
      _$TeachersDaoFromJson(json);
}
