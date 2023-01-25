class Attendance {
  final String classNumber;
  final String teacherName;
  final String className;
  final String uniName;
  const Attendance(
      {required this.className,
      required this.classNumber,
      required this.teacherName,
      required this.uniName})
      : super();
  Attendance.def(
    String? classNu,
  ) : this(
            classNumber: classNu ?? "500",
            teacherName: "کارگر",
            className: "مهارت های زندگی",
            uniName: "دانشکده مهارت");

  static int Function(Attendance, Attendance) sort(
      SortAttendance sortAttendance) {
    switch (sortAttendance) {
      case SortAttendance.sortByNumber:
        return (a1, a2) {
          return a1.classNumber.compareTo(a2.classNumber);
        };
      case SortAttendance.sortByReverseNumber:
        return (a1, a2) {
          return a2.classNumber.compareTo(a1.classNumber);
        };
      case SortAttendance.non:
        return (a1, a2) {
          return a1.classNumber.compareTo(a2.classNumber);
        };
    }
  }
}

enum SortAttendance {
  sortByNumber,
  sortByReverseNumber,
  non,
}
