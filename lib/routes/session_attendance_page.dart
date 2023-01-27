import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:presence_absence/consts/Colors.dart';

import 'package:presence_absence/widgets/class_number_widget.dart';

final _pageMainColor = Colors.white.withOpacity(0.6);
const _pageRadius = Radius.circular(16);

class SessionPage extends StatefulWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  State<SessionPage> createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  late TextEditingController textController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

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
                children: [
                  const _Header(),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                      child: _SessionBody(
                    controller: textController,
                  )),
                  const SizedBox(
                    height: 16,
                  ),
                  _SessionBottom(
                    onClicked: (isAttended) {
                      //TODO check for Text Controller
                      //TODO send respond to Server
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SessionBottom extends StatelessWidget {
  final void Function(bool) onClicked;
  const _SessionBottom({Key? key, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: _pageMainColor,
        borderRadius: const BorderRadius.only(
            topLeft: _pageRadius, topRight: _pageRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: TextButton(
            onPressed: () => onClicked(true),
            child: Text(
              "حضور",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          )),
          const VerticalDivider(
            width: 8,
            thickness: 1,
            indent: 16,
            endIndent: 16,
          ),
          Expanded(
              child: TextButton(
            onPressed: () => onClicked(false),
            child: Text(
              "غایب",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
          )),
        ],
      ),
    );
  }
}

class _SessionBody extends StatelessWidget {
  final TextEditingController controller;
  const _SessionBody({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _pageMainColor,
        borderRadius: const BorderRadius.only(
            topRight: _pageRadius, topLeft: _pageRadius),
      ),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "توضیحات:",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  decoration: TextDecoration.underline,
                ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "انتخابی",
                hintStyle: Theme.of(context).textTheme.titleLarge,
                fillColor: const Color(0xfff2eecb),
                filled: true,
              ),
              clipBehavior: Clip.antiAlias,
              expands: true,
              maxLines: null,
              minLines: null,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          )
        ],
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
            bottomLeft: _pageRadius, bottomRight: _pageRadius),
        color: _pageMainColor,
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
