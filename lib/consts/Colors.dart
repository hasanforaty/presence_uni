import 'package:flutter/material.dart';
import 'package:presence_absence/models/attendacne.dart';

const Color kLogInBackGround = Color(0xff252B2F);
const Color kUnderLineColor = Color(0xff75787C);
const Color kLoginButtonColor = Color(0xff151A1D);
const Color kDrawerBackgroundColor = Color(0xff2A0034);

List<Color> getAttendanceColor(AttendanceStatus status) {
  switch (status) {
    case AttendanceStatus.present:
      {
        return [Colors.greenAccent, Color(0xff2ebf91)];
      }
    case AttendanceStatus.absent:
      {
        return [Colors.redAccent, Colors.red[300]!];
      }
    default:
      {
        return [Color(0xff8360c3), Colors.lightBlueAccent];
      }
  }
}
