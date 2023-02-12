import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:presence_absence/bloc/users_bloc.dart';
import 'package:presence_absence/consts/Colors.dart';
import 'package:presence_absence/consts/consts.dart';
import 'package:presence_absence/models/providers/retrofit_provider.dart';
import 'package:presence_absence/models/roles.dart';
import 'package:presence_absence/routes.dart';
import 'package:presence_absence/widgets/my_passworld.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:dio/dio.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context);
    TextEditingController userNameController = TextEditingController();
    TextEditingController passworldController = TextEditingController();
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
                      controller: passworldController,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () async {
                    pd.show();
                    try {
                      //TODO put check right answer
                      var rest = context.read<RetrofitProvider>();
                      var loginBloc = context.read<UserBloc>();

                      var userDao = await rest.state
                          .login("userName", "password", "application/json");
                      var user = userDao.toUsers();

                      loginBloc.changeUsers(user);

                      if (kDebugMode) {
                        print(user.toString());
                      }
                      if (user.role == Role.admin) {
                        // Navigator.pop(context);
                        RouteGenerator.goTo(Routes.portal,
                            context:
                                RouteGenerator.navigatorKey.currentContext!,
                            replace: true);
                      } else {
                        RouteGenerator.goTo(Routes.attendance,
                            context: context, replace: true);
                      }
                    } catch (e) {
                      var res = (e as DioError).response;
                      print(res?.toString());
                    }
                    await pd.hide();

                    RouteGenerator.goTo(Routes.portal,
                        context: RouteGenerator.navigatorKey.currentContext!,
                        replace: true);
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
