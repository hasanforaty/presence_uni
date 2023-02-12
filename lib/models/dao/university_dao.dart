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
