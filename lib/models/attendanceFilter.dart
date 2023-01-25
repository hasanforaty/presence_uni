import 'package:presence_absence/models/attendacne.dart';

class AttendanceFilter {
  final SortAttendance sort;
  final bool Function(Attendance) filter;
  AttendanceFilter({required this.filter, this.sort = SortAttendance.non})
      : super();

  AttendanceFilter copyWith({
    SortAttendance? sort,
    bool Function(Attendance)? filter,
  }) {
    return AttendanceFilter(
      sort: sort ?? this.sort,
      filter: filter ?? this.filter,
    );
  }
}
