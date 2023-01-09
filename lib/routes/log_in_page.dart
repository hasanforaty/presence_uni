import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:presence_absence/consts/Colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLogInBackGround,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8, right: 8),
        child: Column(
          children: [
            //for pic at top
            Lottie.asset("assets/login_lottie_01.json",
                repeat: true,
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width),
          ],
        ),
      ),
    );
  }
}
