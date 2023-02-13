import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:presence_absence/consts/Colors.dart';
import 'package:presence_absence/consts/consts.dart';
import 'package:presence_absence/consts/retrofit_utils.dart';
import 'package:presence_absence/widgets/my_passworld.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context);
    TextEditingController userNameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Container(
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
                    width: MediaQuery.of(context).size.width),
                Padding(
                  padding: textPadding,
                  child: Text(
                    "ورود",
                    textDirection: TextDirection.rtl,
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
                      controller: userNameController,
                      style: const TextStyle(color: Colors.white),
                      textDirection: TextDirection.rtl,
                      decoration: InputDecoration(
                        label: Center(
                          child: Text(
                            "نام کاربری",
                            textDirection: TextDirection.rtl,
                            style:
                                Theme.of(context).textTheme.caption?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                          ),
                        ),
                        hintText: "نام کاربری خود را وارد نمایید",
                        hintTextDirection: TextDirection.rtl,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(
                                color: kUnderLineColor,
                                fontSize: 16,
                                height: 3),
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
                    child: MyPasswordWidget(
                      controller: passwordController,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () async {
                    var username = userNameController.value.text;
                    var password = passwordController.value.text;
                    //TODO put check right answer
                    if (username.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          "لطفا مقادیر نام کاربری و پسورد را وارد کنید",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white),
                          textDirection: TextDirection.rtl,
                        ),
                        duration: const Duration(seconds: 2),
                      ));
                      return;
                    }
                    pd.show();

                    await logIn(
                        userName: username,
                        password: password,
                        context: context,
                        onFinished: () {
                          pd.hide();
                        });
                    //TODO delete when server fixed
                    // RouteGenerator.goTo(Routes.portal,
                    //     context: RouteGenerator.navigatorKey.currentContext!,
                    //     replace: true);
                  },
                  child: Container(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
