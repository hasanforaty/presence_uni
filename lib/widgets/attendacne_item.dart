import 'package:flutter/material.dart';
import 'package:presence_absence/consts/Colors.dart';
import 'package:presence_absence/models/attendacne.dart';
import 'package:presence_absence/widgets/class_number_widget.dart';

class AttendanceItem extends StatelessWidget {
  final String attendanceNumber;
  final String teacherName;
  final String className;
  final String uniName;
  final void Function() onClicked;
  final AttendanceStatus status;
  const AttendanceItem({
    Key? key,
    required this.attendanceNumber,
    required this.onClicked,
    required this.teacherName,
    required this.className,
    required this.uniName,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onClicked,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: getAttendanceColor(status),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              boxShadow: const [
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
              ClassNumberWidget(classNumber: attendanceNumber),
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
                      Expanded(
                          child: Center(
                              child: Text(
                        "کلاس : $className",
                        style: Theme.of(context).textTheme.labelLarge,
                      ))),
                      Expanded(
                          child: Center(
                              child: Text(
                        uniName,
                        style: Theme.of(context).textTheme.labelLarge,
                      ))),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
