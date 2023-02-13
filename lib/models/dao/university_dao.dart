import 'package:json_annotation/json_annotation.dart';

part 'university_dao.g.dart';

@JsonSerializable()
class UniversityDao {
  int id;
  String name;

  UniversityDao({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() => _$UniversityDaoToJson(this);
  factory UniversityDao.fromJson(Map<String, dynamic> json) =>
      _$UniversityDaoFromJson(json);
}

@JsonSerializable()
class UniversitiesDao {
  List<UniversityDao> data;

  UniversitiesDao({
    required this.data,
  });
  Map<String, dynamic> toJson() => _$UniversitiesDaoToJson(this);
  factory UniversitiesDao.fromJson(Map<String, dynamic> json) =>
      _$UniversitiesDaoFromJson(json);
}
