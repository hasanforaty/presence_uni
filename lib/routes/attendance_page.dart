import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:presence_absence/consts/Colors.dart';
import 'package:presence_absence/widgets/CustomSliverAppBar.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: kLogInBackGround,
        child: CustomScrollView(
          slivers: [
            const _MyAppBarSliver_1(),
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
        appBar: AppBar(
          backgroundColor: kLogInBackGround.withOpacity(0.5),
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
      children: [
        Expanded(
          child: IconButton(
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.arrowUpAZ),
          ),
        ),
        Expanded(
          child: MyIconButton(
            onPressed: () {},
            iconData: (FontAwesomeIcons.arrowUp19),
          ),
        ),
        Expanded(
          child: IconButton(
            splashColor: kLogInBackGround,
            onPressed: () {},
            icon: const FaIcon(FontAwesomeIcons.filter),
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
