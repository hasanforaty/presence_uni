import 'package:flutter/material.dart';

class ClassNumberWidget extends StatelessWidget {
  final String classNumber;
  const ClassNumberWidget({Key? key, required this.classNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: classNumber,
      child: Text(
        classNumber,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.white, fontSize: 40),
      ),
    );
  }
}
