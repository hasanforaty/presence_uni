import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presence_absence/models/users.dart';

class UserBloc extends Cubit<Users> {
  UserBloc() : super(Users.def());
  void changeUsers(Users newUser) => emit(newUser);
  void invalidate() => emit(state.copyWith(auth: ""));
}
