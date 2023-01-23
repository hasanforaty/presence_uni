import 'package:flutter/material.dart';

class AttendanceItem extends StatelessWidget {
  final String attendanceNumber;
  final String teacherName;
  const AttendanceItem(
      {Key? key, required this.attendanceNumber, this.teacherName = "باقری"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xff8360c3), Color(0xff2ebf91)],
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(2, 10),
                color: Colors.black87,
                blurRadius: 12,
              ),
            ]),
        height: 100,
        child: Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Text(
              attendanceNumber,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.white, fontSize: 40),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
                child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                padding: const EdgeInsets.only(
                    top: 16.0, bottom: 16, right: 8, left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "استاد : $teacherName",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontSize: 16),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
