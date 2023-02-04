import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:presence_absence/consts/Colors.dart';

import '../models/providers/drawer_controller_bloc.dart';

class PortalPage extends StatelessWidget {
  const PortalPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrawerControllerBloc, ZoomDrawerController>(
        builder: (context, controller) {
      return Stack(
        children: [
          Container(
            color: kLogInBackGround,
          ),
          ZoomDrawer(
            controller: controller,
            drawerShadowsBackgroundColor: Colors.grey,
            slideWidth: MediaQuery.of(context).size.width * 0.65,
            showShadow: true,
            angle: 0.0,
            menuScreen: Container(
              color: Colors.blue,
            ),
            mainScreen: _MainPage(
              controller: controller,
            ),
          ),
        ],
      );
    });
  }
}

class _MainPage extends StatefulWidget {
  final ZoomDrawerController controller;
  const _MainPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<_MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<_MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLogInBackGround,
      child: Column(
        children: [
          AppBar(
            leading: IconButton(
              icon: const Icon(Icons.menu_open_outlined),
              onPressed: () {
                widget.controller.toggle!();
              },
            ),
          )
        ],
      ),
    );
  }
}
