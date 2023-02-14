import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/models/attendacne.dart';
import 'package:presence_absence/models/attendanceFilter.dart';
import 'package:presence_absence/models/dao/university_dao.dart';

class AttendanceFilterBloc extends Cubit<AttendanceFilter> {
  AttendanceFilterBloc() : super(AttendanceFilter(filteredUniversity: []));

  void changeSort(SortAttendance sort) => emit(state.copyWith(sort: sort));
  void changeSelectedUni(List<UniversityDao> list) =>
      emit(state.copyWith(filteredUniversity: list));
}
