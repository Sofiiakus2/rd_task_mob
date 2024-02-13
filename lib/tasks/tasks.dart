class Task {
  final String title;
  final String performer;
  final String date;
  final double progress;
  final String result;
  final List<String> miniTasks;
  final String assigner;
  final List<String>? assignees;

  Task({
    required this.title,
    required this.performer,
    required this.date,
    required this.progress,
    required this.result,
    required this.miniTasks,
    required this.assigner,
    this.assignees,
  });
}
