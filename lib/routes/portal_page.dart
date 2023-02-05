import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:presence_absence/consts/Colors.dart';
import 'package:presence_absence/routes.dart';
import 'package:presence_absence/widgets/drawer_item.dart';

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
            isRtl: true,
            drawerShadowsBackgroundColor: Colors.grey,
            slideWidth: MediaQuery.of(context).size.width * 0.65,
            showShadow: true,
            angle: 0.0,
            menuScreen: Container(
              decoration: const BoxDecoration(
                  color: kDrawerBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: SafeArea(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          "ahmadi",
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontStyle: FontStyle.italic,
                                  ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DrawerItem(
                          onPressed: () {
                            RouteGenerator.goTo(context, Routes.attendance);
                          },
                          iconData: Icons.add_card,
                          name: "حضور و غیاب"),
                      DrawerItem(
                          onPressed: () {
                            //TODO go to upload page
                          },
                          iconData: Icons.upload,
                          name: "ارسال فایل"),
                      DrawerItem(
                        onPressed: () {},
                        iconData: Icons.bar_chart,
                        name: "نمودار ها (درحال توسعه)",
                        isActive: false,
                      ),
                      Expanded(child: Container()),
                      DrawerItem(
                          onPressed: () {
                            //TODO Logout with making users bloc null
                          },
                          iconData: Icons.logout,
                          name: "خروج"),
                    ],
                  ),
                ),
              ),
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
            actions: [
              IconButton(
                icon: const Icon(Icons.menu_open_outlined),
                onPressed: () {
                  widget.controller.toggle!();
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
