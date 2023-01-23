import 'package:flutter/material.dart';
import 'package:presence_absence/consts/Colors.dart';

class SessionPage extends StatelessWidget {
  const SessionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLogInBackGround,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
