import 'package:presence_absence/models/attendacne.dart';
import 'package:presence_absence/models/university.dart';

class AttendanceFilter {
  final SortAttendance sort;
  final List<University> filteredUniversity;
  AttendanceFilter(
      {this.sort = SortAttendance.non, required this.filteredUniversity})
      : super();

  bool Function(Attendance) createFilter() => (item) {
        if (filteredUniversity.isEmpty) return true;
        for (University filter in filteredUniversity) {
          if (filter.name == item.uniName) return true;
        }
        return false;
      };

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
