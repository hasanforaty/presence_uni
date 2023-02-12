import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/models/dao/university_dao.dart';

class UniversitiesBloc extends Cubit<List<UniversityDao>> {
  UniversitiesBloc() : super(<UniversityDao>[]);
  void newUniversities(List<UniversityDao> list) => emit(list);
  List<UniversityDao> getUniversities() => state;
}
