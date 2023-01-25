import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/models/attendacne.dart';
import 'package:presence_absence/models/attendanceFilter.dart';

class AttendanceFilterBloc extends Cubit<AttendanceFilter> {
  AttendanceFilterBloc() : super(AttendanceFilter(filter: (_) => true));

  void changeSort(SortAttendance sort) => emit(state.copyWith(sort: sort));
  void changeFilter(bool Function(Attendance) newFilter) =>
      emit(state.copyWith(filter: newFilter));
}
