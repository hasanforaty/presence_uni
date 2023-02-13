import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'Colors.dart';

EdgeInsets textPadding = const EdgeInsets.only(top: 16, right: 32, left: 32);
InterceptorsWrapper myInternetIntercepter =
    InterceptorsWrapper(onRequest: (rOption, handler) {
  print("in request : ${rOption.uri.toString()}");
  handler.next(rOption);
}, onResponse: (response, handler) {
  print("in response : ${response.toString()}");
  return handler.next(response);
}, onError: (error, handler) {
  print("in Error : ${error.response.toString()}");
  handler.next(error);
});
InputDecoration getTextInputDecoration(BuildContext context,
    {Widget? label, String? hint}) {
  return InputDecoration(
    label: label,
    contentPadding: const EdgeInsets.only(right: 8, left: 8),
    hintText: hint,
    hintStyle:
        Theme.of(context).textTheme.caption?.copyWith(color: kUnderLineColor),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: kUnderLineColor,
      ),
    ),
  );
}
