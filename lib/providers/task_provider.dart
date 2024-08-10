import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  final List<Task> _tasks = [
    Task(
      title: 'Flutter Çalış',
      isDone: true,
    ),
    Task(
      title: 'İngilizce Çalış',
    ),
    Task(
      title: 'Spora Git',
    ),
    Task(
      title: 'Yürüyüş Yap',
      isDone: true,
    ),
    Task(
      title: 'Kitap Oku',
    ),
  ];

  List<Task> get tasks => _tasks;

  void toggleTaskStatus(Task task) {
    if (!task.isDisabled) {
      task.toggleDone();
      notifyListeners();
    }
  }

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void addSubtask(Task parentTask, Task subtask) {
    parentTask.subtasks = parentTask.subtasks ?? [];
    parentTask.subtasks.add(subtask);
    notifyListeners();
  }
}
