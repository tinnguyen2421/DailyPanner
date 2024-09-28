class Task {
  String day;
  String date;
  String content;
  String startTime;
  String endTime;
  String location;
  List<String> chairs;
  String note;
  String approvalStatus;
  String approver;

  Task({
    required this.day,
    required this.date,
    required this.content,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.chairs,
    required this.note,
    required this.approvalStatus,
    required this.approver,
  });
}
