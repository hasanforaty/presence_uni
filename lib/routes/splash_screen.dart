import 'package:flutter/material.dart';
import 'package:presence_absence/consts/Colors.dart';
import 'package:presence_absence/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3))
        .then((value) => RouteGenerator.goTo(Routes.logIn, replace: true));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: kLogInBackGround,
          image: DecorationImage(
            image: AssetImage("assets/image/uni_icon.png"),
          )),
    );
  }
}
