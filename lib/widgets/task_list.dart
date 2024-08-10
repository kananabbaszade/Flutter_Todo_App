import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasked_app/models/task.dart';
import 'package:tasked_app/theme/color.dart';
import '../providers/task_provider.dart';
import 'task_item.dart';

class TaskList extends StatelessWidget {
  final Function(Task) toggleAddSubtask;

  TaskList(this.toggleAddSubtask);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return ListView.builder(
          itemCount: taskProvider.tasks.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: tdBlack.withOpacity(.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TaskItem(
                      task: taskProvider.tasks[index],
                      toggleAddSubtask: toggleAddSubtask),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
