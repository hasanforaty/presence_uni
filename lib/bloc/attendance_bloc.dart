import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/models/attendacne.dart';

class AttendacneRepo extends Cubit<List<Attendance>> {
  AttendacneRepo()
      : super(List.generate(
            100, (index) => Attendance.def((5000 + index).toString())));

  List<Attendance> getCurrentList() => state;
  void add(Attendance attendance) => emit(getCurrentList()..add(attendance));
  void replace(List<Attendance> list) => emit(list);
  void remove(Attendance attendance) =>
      emit(getCurrentList()..remove(attendance));
}
