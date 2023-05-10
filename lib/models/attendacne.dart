class Attendance {
  final AttendanceStatus status;
  final String classNumber;
  final String teacherName;
  final String className;
  final String uniName;
  final int? sessionId;
  final String numberOfStudent;
  final String? comment;
  final int courseId;
  final int locaitonId;
  const Attendance({
    required this.className,
    required this.classNumber,
    required this.teacherName,
    required this.uniName,
    required this.numberOfStudent,
    required this.sessionId,
    required this.status,
    required this.courseId,
    required this.locaitonId,
    this.comment,
  }) : super();
  Attendance.def(
    String? classNu,
  ) : this(
            classNumber: classNu ?? "500",
            teacherName: "کارگر",
            className: "مهارت های زندگی",
            uniName: "دانشکده مهارت",
            sessionId: 10,
            numberOfStudent: "25",
            status: AttendanceStatus.unDecided,
            locaitonId: 0,
            courseId: 0);

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

enum AttendanceStatus { absent, present, unDecided }

enum SortAttendance {
  sortByNumber,
  sortByReverseNumber,
  non,
}
