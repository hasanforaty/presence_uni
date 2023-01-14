import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:presence_absence/consts/Colors.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: kLogInBackGround,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
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
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.fadeTitle
              ],
            ),
            expandedHeight: 200,
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.red,
                  height: 100,
                ),
              );
            },
            childCount: 200,
          ))
        ],
      ),
    );
  }
}
