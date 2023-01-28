import 'package:presence_absence/models/attendacne.dart';
import 'package:presence_absence/models/university.dart';

class AttendanceFilter {
  final SortAttendance sort;
  final List<University> filteredUniversity;
  AttendanceFilter(
      {this.sort = SortAttendance.non, required this.filteredUniversity})
      : super();

  bool Function(Attendance) createFilter() => (item) {
        if (!isFilterActive()) return true;
        for (University filter in filteredUniversity) {
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
    List<University>? filteredUniversity,
  }) {
    return AttendanceFilter(
      sort: sort ?? this.sort,
      filteredUniversity: filteredUniversity ?? this.filteredUniversity,
    );
  }
}
