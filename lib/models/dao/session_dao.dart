import 'package:json_annotation/json_annotation.dart';

part 'session_dao.g.dart';

@JsonSerializable()
class SessionDAO {
  String id;
  String course_id;
  String location_id;
  String status;
  String comment;

  SessionDAO({
    required this.id,
    required this.course_id,
    required this.location_id,
    required this.status,
    required this.comment,
  });

  Map<String, dynamic> toJson() => _$SessionDAOToJson(this);
  factory SessionDAO.fromJson(Map<String, dynamic> json) =>
      _$SessionDAOFromJson(json);
}
