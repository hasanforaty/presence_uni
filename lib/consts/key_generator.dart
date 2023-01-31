import 'package:flutter/material.dart';
import 'package:presence_absence/models/attendacne.dart';

extension KeyGeneration on Attendance {
  Key getKey() => ValueKey("$classNumber/$sessionId");
}
