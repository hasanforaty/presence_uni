import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:presence_absence/models/attendanceFilter.dart';

class FilterButton extends StatelessWidget {
  final AttendanceFilter filter;
  final void Function() onPressed;
  const FilterButton({Key? key, required this.filter, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Stack(
          fit: StackFit.passthrough,
          clipBehavior: Clip.antiAlias,
          children: [
            Icon(
              filter.numberOfFilteredActive() > 0
                  ? Icons.filter_list_sharp
                  : Icons.filter_list_off_rounded,
              size: 40,
            ),
            Visibility(
              visible: filter.numberOfFilteredActive() > 0,
              child: Positioned(
                top: 0,
                left: 0,
                child: Container(
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Center(
                    child: Text(
                      filter.numberOfFilteredActive().toString(),
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall
                          ?.copyWith(fontSize: 20, color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
