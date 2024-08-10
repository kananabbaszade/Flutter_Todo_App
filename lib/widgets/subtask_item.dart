import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tasked_app/theme/color.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class SubtaskItem extends StatelessWidget {
  final Task subtask;
  final Task parentTask;

  SubtaskItem({required this.subtask, required this.parentTask});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: subtask.isDone,
        onChanged: subtask.isDisabled
            ? null
            : (value) {
                Provider.of<TaskProvider>(context, listen: false)
                    .toggleTaskStatus(subtask);
              },
      ),
      title: Text(
        subtask.title,
        style: GoogleFonts.alata(
          color: subtask.isDisabled
              ? tdBlack
              : const Color.fromARGB(255, 255, 255, 255),
          decoration: subtask.isDone ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
