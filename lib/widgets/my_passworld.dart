import 'package:flutter/material.dart';

import '../consts/Colors.dart';

class MyPasswordWidget extends StatefulWidget {
  const MyPasswordWidget({Key? key}) : super(key: key);

  @override
  State<MyPasswordWidget> createState() => _MyPasswordWidgetState();
}

class _MyPasswordWidgetState extends State<MyPasswordWidget> {
  var isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        label: Text(
          "رمز",
          style: Theme.of(context).textTheme.caption?.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
        ),
        hintText: "رمز ورود خود را وارد نمایید",
        hintStyle: Theme.of(context).textTheme.caption?.copyWith(
              color: kUnderLineColor,
            ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kUnderLineColor,
          ),
        ),
      ),
    );
  }
}
