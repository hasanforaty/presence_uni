import 'package:json_annotation/json_annotation.dart';

part 'session_dao.g.dart';

@JsonSerializable()
class SessionDAO {
  int? id;
  int course_id;
  int location_id;
  String? status;
  String? comment;
  String time;

  SessionDAO({
    this.id,
    required this.course_id,
    required this.location_id,
    required this.status,
    required this.comment,
    required this.time,
  });

  Map<String, dynamic> toJson() => _$SessionDAOToJson(this);
  factory SessionDAO.fromJson(Map<String, dynamic> json) =>
      _$SessionDAOFromJson(json);
}

@JsonSerializable()
class SessionsDAO {
  List<SessionDAO> data;

  SessionsDAO({
    required this.data,
  });
  Map<String, dynamic> toJson() => _$SessionsDAOToJson(this);
  factory SessionsDAO.fromJson(Map<String, dynamic> json) =>
      _$SessionsDAOFromJson(json);
}
