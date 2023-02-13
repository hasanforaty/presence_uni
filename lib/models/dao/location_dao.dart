import 'package:json_annotation/json_annotation.dart';
part 'location_dao.g.dart';

@JsonSerializable()
class LocationDao {
  int id;
  int university_id;
  int class_number;
  int floor;

  LocationDao({
    required this.id,
    required this.university_id,
    required this.class_number,
    required this.floor,
  });
  Map<String, dynamic> toJson() => _$LocationDaoToJson(this);
  factory LocationDao.fromJson(Map<String, dynamic> json) =>
      _$LocationDaoFromJson(json);
}

@JsonSerializable()
class LocationsDao {
  List<LocationDao> data;

  LocationsDao({
    required this.data,
  });
  Map<String, dynamic> toJson() => _$LocationsDaoToJson(this);
  factory LocationsDao.fromJson(Map<String, dynamic> json) =>
      _$LocationsDaoFromJson(json);
}
