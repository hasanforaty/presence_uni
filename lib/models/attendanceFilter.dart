import 'package:presence_absence/models/attendacne.dart';
import 'package:presence_absence/models/dao/university_dao.dart';
import 'package:presence_absence/models/university.dart';

class AttendanceFilter {
  final SortAttendance sort;
  final List<UniversityDao> filteredUniversity;
  final List<String> filteredClassHours;
  AttendanceFilter(
      {this.sort = SortAttendance.non,
      required this.filteredUniversity,
      required this.filteredClassHours})
      : super();

  bool Function(Attendance) createFilter() => (item) {
        if (!isFilterActive()) return true;
        for (UniversityDao filter in filteredUniversity) {
          if (filter.name == item.uniName) {
            if (filteredClassHours.isEmpty) return true;
            return filteredClassHours.contains(item.times);
          }
        }
        for (String filter in filteredClassHours) {
          if (filter == item.times) {
            if (filteredUniversity.isEmpty) return true;
          }
        }
        return false;
      };
  bool isFilterActive() {
    if (filteredUniversity.isEmpty && filteredClassHours.isEmpty) return false;
    return true;
  }

  int numberOfFilteredActive() {
    if (!isFilterActive()) return 0;
    return filteredUniversity.length + filteredClassHours.length;
  }

  AttendanceFilter copyWith({
    SortAttendance? sort,
    List<UniversityDao>? filteredUniversity,
    List<String>? filteredClassHours,
  }) {
    return AttendanceFilter(
      sort: sort ?? this.sort,
      filteredUniversity: filteredUniversity ?? this.filteredUniversity,
      filteredClassHours: filteredClassHours ?? this.filteredClassHours,
    );
  }
}
