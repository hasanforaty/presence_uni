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
}
