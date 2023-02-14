import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:presence_absence/routes.dart';
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
  var message = "";
  switch (error.response?.statusCode ?? 0) {
    case 403:
      message = "دسترسی شما کافی نیست";
      break;
    case 401:
      message = "دسترسی کافی به شما داده نشد";
      break;
    case 404:
      message = "پیدا نشد لطفا به پشتیبانی تماس حاصل فرمایید";
      break;
    case 500:
      message = "اررور 500 لطفا به پشتیبان تماس حاصل فرمایید";
      break;
  }
  if (message.isEmpty) message = error.message;

  ScaffoldMessenger.of(RouteGenerator.navigatorKey.currentContext!)
      .showSnackBar(
    SnackBar(
      content: Text(
        message,
        textDirection: TextDirection.rtl,
        style: Theme.of(RouteGenerator.navigatorKey.currentContext!)
            .textTheme
            .titleMedium
            ?.copyWith(color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ),
  );

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
