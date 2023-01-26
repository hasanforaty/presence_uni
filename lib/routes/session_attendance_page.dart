import 'package:flutter/material.dart';
import 'package:presence_absence/consts/Colors.dart';

import 'package:presence_absence/widgets/class_number_widget.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLogInBackGround,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: const [_Header()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
        color: Colors.white.withOpacity(0.6),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: const [
            _ClassNumberWidget(classNumber: "5000"),
            VerticalDivider(
              color: Colors.black87,
              indent: 16,
              endIndent: 16,
            ),
            Expanded(
                child: _HeaderInfo(
                    className: "مهارت های زندگی", teacherName: "کارگر")),
            _StudentNumber(number: "25")
          ],
        ),
      ),
    );
  }
}

class _ClassNumberWidget extends StatelessWidget {
  final String classNumber;
  const _ClassNumberWidget({Key? key, required this.classNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "کلاس",
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.white, fontSize: 40),
        ),
        const SizedBox(
          width: 8,
        ),
        ClassNumberWidget(classNumber: classNumber),
      ],
    );
  }
}

class _HeaderInfo extends StatelessWidget {
  final String className;
  final String teacherName;

  const _HeaderInfo(
      {Key? key, required this.className, required this.teacherName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontSize: 20,
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text(className, style: textStyle),
        Text(
          teacherName,
          style: textStyle,
        ),
        const SizedBox(
          height: 16,
        ),
      ],
    );
  }
}

class _StudentNumber extends StatelessWidget {
  final String number;
  const _StudentNumber({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: kLogInBackGround,
        ),
        child: Center(
          child: Text(
            number,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
