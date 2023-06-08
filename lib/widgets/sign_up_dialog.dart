import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:presence_absence/consts/retrofit_utils.dart';
import 'package:presence_absence/models/repositories/restClient.dart';
import '../models/providers/retrofit_provider.dart';

class SignUpDialog extends StatefulWidget {
  const SignUpDialog({Key? key}) : super(key: key);

  @override
  State<SignUpDialog> createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height - 100,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        decoration: BoxDecoration(
          color: const Color(0xffD7D6D7).withOpacity(0.94),
          borderRadius: const BorderRadius.all(Radius.circular(40)),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SizedBox(
                height: MediaQuery.of(context).size.height - 108,
                child: ListView(
                  children: [
                    Text(
                      "ثبت نام",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const _SignUpForm(),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: -48,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm({Key? key}) : super(key: key);

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  GlobalKey<FormState> formKey = GlobalKey();
  GlobalKey<FormFieldState> _nameKey = GlobalKey();
  GlobalKey<FormFieldState> _passwordKey = GlobalKey();
  GlobalKey<FormFieldState> _emailKey = GlobalKey();
  GlobalKey<FormFieldState> _typeKey = GlobalKey();
  String controllerValue = "ناظر";
  String adminValue = "ناظر عالی";
  late String selectedValue;
  @override
  Widget build(BuildContext context) {
    selectedValue = controllerValue;
    var rest = context.read<RetrofitProvider>().state;
    return Form(
        key: formKey,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                  child: Text(
                    "نام",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                TextFormField(
                  key: _nameKey,
                  textDirection: TextDirection.rtl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "لطفا نام خود را وارد نمایید";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black87, width: 2)),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset("assets/icons/User.svg"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                  child: Text(
                    "ایمیل",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                TextFormField(
                  key: _emailKey,
                  textDirection: TextDirection.rtl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "لطفا ایمیل خود را وارد نمایید";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black87, width: 2)),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset("assets/icons/email.svg"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                  child: Text(
                    "رمز",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
                TextFormField(
                  key: _passwordKey,
                  textDirection: TextDirection.rtl,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "لطفا پسورد مورد نظر را وارد نمایید";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.black87, width: 2)),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: SvgPicture.asset("assets/icons/password.svg"),
                    ),
                  ),
                ),
                Builder(builder: (context) {
                  return DropdownButtonFormField<String>(
                    key: _typeKey,
                    items: [
                      DropdownMenuItem<String>(
                        value: controllerValue,
                        child: Text(
                          controllerValue,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: adminValue,
                        child:
                            Text(adminValue, textDirection: TextDirection.rtl),
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value ?? controllerValue;
                      });
                    },
                    value: selectedValue,
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 24),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      signingUp(rest, context);
                    },
                    icon: const Icon(CupertinoIcons.arrow_right),
                    label: const Text("ثبت نام"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff77d8e),
                      minimumSize: const Size(double.infinity, 56),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  void signingUp(RestClient restClient, BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      await signUp(
          rest: restClient,
          username: _emailKey.currentState?.value ?? "",
          password: _passwordKey.currentState?.value ?? "",
          role: _typeKey.currentState?.value ?? "",
          name: _nameKey.currentState?.value ?? "");
      Navigator.pop(context);
    }
  }
}
