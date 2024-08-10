import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tasked_app/theme/color.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'subtask_item.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(Task) toggleAddSubtask;

  TaskItem({required this.task, required this.toggleAddSubtask});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      backgroundColor: tdBGColor.withOpacity(.5),
      collapsedShape: RoundedRectangleBorder(
        side: BorderSide(
            color: Colors.transparent), // Kapatılmışken alt çizgiyi kaldırır
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color:
                Color.fromARGB(0, 0, 0, 120)), // Açıkken alt çizgiyi kaldırır
      ),
      leading: Checkbox(
        checkColor: tdBlack,
        activeColor: tdRed,
        value: task.isDone,
        onChanged: task.isDisabled
            ? null
            : (value) {
                Provider.of<TaskProvider>(context, listen: false)
                    .toggleTaskStatus(task);
              },
      ),
      title: Text(
        task.title,
        style: GoogleFonts.alata(
          color: task.isDisabled ? tdGrey : Colors.white,
          decoration: task.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
      children: [
        ...task.subtasks.map((subtask) {
          return SubtaskItem(subtask: subtask, parentTask: task);
        }).toList(),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: TextButton(
              style: ButtonStyle(alignment: Alignment.bottomCenter),
              onPressed: () => toggleAddSubtask(task),
              child: Text(
                textAlign: TextAlign.start,
                'Alt görev ekle',
                style: GoogleFonts.alata(
                  color: tdRed.withOpacity(.8),
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
