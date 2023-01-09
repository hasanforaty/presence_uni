import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:presence_absence/consts/Colors.dart';
import 'package:presence_absence/consts/consts.dart';
import 'package:presence_absence/widgets/my_passworld.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLogInBackGround,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              //for pic at top
              Lottie.asset("assets/lottie/login_lottie_01.json",
                  repeat: true,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width),
              Padding(
                padding: textPadding,
                child: Text(
                  "ورود",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                ),
              ),
              //Username
              Padding(
                padding: textPadding,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      label: Text(
                        "نام کاربری",
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                      ),
                      hintText: "نام کاربری خود را وارد نمایید",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: kUnderLineColor),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: kUnderLineColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Password
              Padding(
                padding: textPadding,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const MyPasswordWidget(),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 36, right: 36),
                decoration: const BoxDecoration(
                    color: kLoginButtonColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white10,
                        offset: Offset(0, 5),
                        spreadRadius: 0.5,
                        blurRadius: 10,
                      )
                    ]),
                child: Center(
                  child: Text(
                    "ورود",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
