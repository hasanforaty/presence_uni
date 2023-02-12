import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/models/dao/course_dao.dart';

class CourseBloc extends Cubit<List<CourseDAO>> {
  CourseBloc() : super(<CourseDAO>[]);
  void newCourses(List<CourseDAO> list) => emit(list);
  List<CourseDAO> getCourse() => state;
}
