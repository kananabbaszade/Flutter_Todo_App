class Task {
  String title;
  bool isDone;
  bool isDisabled;
  List<Task> subtasks;

  Task({
    required this.title,
    this.isDone = false,
    this.isDisabled = false,
    List<Task>? subtasks,
  }) : this.subtasks = subtasks ?? [];

  void toggleDone() {
    isDone = !isDone;
  }
}
