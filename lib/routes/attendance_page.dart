import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:presence_absence/bloc/attendacne_filter_bloc.dart';
import 'package:presence_absence/bloc/attendances_bloc.dart';
import 'package:presence_absence/bloc/selected_attendance_bloc.dart';
import 'package:presence_absence/consts/Colors.dart';
import 'package:presence_absence/models/attendacne.dart';
import 'package:presence_absence/models/attendanceFilter.dart';
import 'package:presence_absence/routes.dart';
import 'package:presence_absence/widgets/CustomSliverAppBar.dart';
import 'package:presence_absence/widgets/attendacne_item.dart';
import 'package:presence_absence/widgets/filter_dialog.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AttendacneRepo>(create: (_) => AttendacneRepo()),
          BlocProvider<AttendanceFilterBloc>(
              create: (_) => AttendanceFilterBloc()),
        ],
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: kLogInBackGround,
          child: CustomScrollView(
            slivers: [
              const _MyAppBarSliver_1(),
              BlocBuilder<AttendacneRepo, List<Attendance>>(
                  builder: (context, items) {
                return BlocBuilder<AttendanceFilterBloc, AttendanceFilter>(
                    builder: (context, filter) {
                  var list = items
                    ..where(filter.filter)
                    ..sort(Attendance.sort(filter.sort));
                  return SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var item = list[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AttendanceItem(
                          attendanceNumber: item.classNumber,
                          className: item.className,
                          teacherName: item.teacherName,
                          uniName: item.uniName,
                          onClicked: () {
                            context.read<SelectedAttendanceBloc>().setNew(item);
                            RouteGenerator.goTo(context, Routes.session);
                          },
                        ),
                      );
                    },
                    childCount: list.length,
                  ));
                });
              })
            ],
          ),
        ),
      ),
    );
  }
}

class _MyAppBarSliver_1 extends StatelessWidget {
  const _MyAppBarSliver_1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: true,
      delegate: CustomSliverAppBar(
        expandedHeight: 200,
        onStretch: () async {
          //TODO refresh the list.
        },
        background: DecoratedBox(
          position: DecorationPosition.background,
          decoration: const BoxDecoration(
            color: kLogInBackGround,
          ),
          child: LottieBuilder.asset(
            "assets/lottie/attendance_1.json",
            repeat: true,
            fit: BoxFit.fill,
          ),
        ),
        //15.5
        appBar: AppBar(
          backgroundColor: kLogInBackGround.withOpacity(0.5),
          flexibleSpace: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
          title: Text(
            "حضور و غیاب",
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white),
          ),
          centerTitle: true,
        ),
        sortWidget: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  // offset: Offset(5, 10),
                  color: kLogInBackGround,
                  blurRadius: 30,
                )
              ]),
          height: 60,
          child: const SortWidgets(),
        ),
      ),
    );
  }
}

class SortWidgets extends StatelessWidget {
  const SortWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: MyIconButton(
            onPressed: () {
              context
                  .read<AttendanceFilterBloc>()
                  .changeSort(SortAttendance.sortByNumber);
            },
            iconData: FontAwesomeIcons.arrowUpAZ,
          ),
        ),
        Expanded(
          child: MyIconButton(
            onPressed: () {
              context
                  .read<AttendanceFilterBloc>()
                  .changeSort(SortAttendance.sortByReverseNumber);
            },
            iconData: (FontAwesomeIcons.arrowDownAZ),
          ),
        ),
        Expanded(
          child: MyIconButton(
            onPressed: () {
              showFilter(context);
            },
            iconData: FontAwesomeIcons.filter,
          ),
        ),
      ],
    );
  }
}

class MyIconButton extends StatelessWidget {
  final void Function() onPressed;
  final IconData iconData;
  final bool isActive;
  const MyIconButton(
      {Key? key,
      required this.onPressed,
      required this.iconData,
      this.isActive = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (isActive) ? onPressed : () {},
      style: ElevatedButton.styleFrom(
        primary: Colors.transparent,
        elevation: 0,
      ),
      child: FaIcon(
        iconData,
        color: (isActive) ? Colors.black : Colors.grey,
      ),
    );
  }
}

class _MyAppBarSliver_2 extends StatelessWidget {
  const _MyAppBarSliver_2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      snap: true,
      stretch: true,
      onStretchTrigger: () async {
        //TODO refresh the list
      },
      flexibleSpace: FlexibleSpaceBar(
        background: LottieBuilder.asset(
          "assets/lottie/attendance_1.json",
          repeat: true,
          fit: BoxFit.fill,
        ),
        title: Text(
          "حضور و غیاب",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: true,
        stretchModes: const [StretchMode.blurBackground, StretchMode.fadeTitle],
      ),
      expandedHeight: 200,
    );
  }
}
