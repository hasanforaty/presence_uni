import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/models/attendacne.dart';

class SelectedAttendanceBloc extends Cubit<Attendance?> {
  SelectedAttendanceBloc() : super(null);
  void setNew(Attendance newAttendance) => emit(newAttendance);
  void remove() => emit(null);
}
