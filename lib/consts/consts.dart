import 'package:flutter/material.dart';

import 'Colors.dart';

EdgeInsets textPadding = const EdgeInsets.only(top: 16, right: 32, left: 32);

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
