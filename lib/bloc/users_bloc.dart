import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/models/dao/users_dao.dart';

class UsersBloc extends Cubit<List<UserDaoData>> {
  UsersBloc() : super([]);
  void change(List<UserDaoData> data) => emit(data);
}
