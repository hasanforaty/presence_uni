import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';

class DrawerControllerBloc extends Cubit<ZoomDrawerController> {
  DrawerControllerBloc() : super(ZoomDrawerController());
}
