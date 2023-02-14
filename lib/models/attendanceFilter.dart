import 'package:presence_absence/models/attendacne.dart';
import 'package:presence_absence/models/dao/university_dao.dart';
import 'package:presence_absence/models/university.dart';

class AttendanceFilter {
  final SortAttendance sort;
  final List<UniversityDao> filteredUniversity;
  AttendanceFilter(
      {this.sort = SortAttendance.non, required this.filteredUniversity})
      : super();

  bool Function(Attendance) createFilter() => (item) {
        if (!isFilterActive()) return true;
        for (UniversityDao filter in filteredUniversity) {
          if (filter.name == item.uniName) return true;
        }
        return false;
      };
  bool isFilterActive() {
    if (filteredUniversity.isEmpty) return false;
    return true;
  }

  int numberOfFilteredActive() {
    if (!isFilterActive()) return 0;
    return filteredUniversity.length;
  }

  AttendanceFilter copyWith({
    SortAttendance? sort,
    List<UniversityDao>? filteredUniversity,
  }) {
    return AttendanceFilter(
      sort: sort ?? this.sort,
      filteredUniversity: filteredUniversity ?? this.filteredUniversity,
    );
  }
}
