import 'package:flutter/material.dart';

import '../consts/Colors.dart';

class MyPasswordWidget extends StatefulWidget {
  final TextEditingController controller;
  const MyPasswordWidget({Key? key, required this.controller})
      : super(key: key);

  @override
  State<MyPasswordWidget> createState() => _MyPasswordWidgetState();
}

class _MyPasswordWidgetState extends State<MyPasswordWidget> {
  var isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white),
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        label: Center(
          child: Text(
            "رمز عبور ",
            style: Theme.of(context).textTheme.caption?.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        hintText: "رمز ورود خود را وارد نمایید",
        hintTextDirection: TextDirection.rtl,
        hintStyle: Theme.of(context)
            .textTheme
            .caption
            ?.copyWith(color: kUnderLineColor, fontSize: 16, height: 3),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: kUnderLineColor,
          ),
        ),
      ),
    );
  }
}
