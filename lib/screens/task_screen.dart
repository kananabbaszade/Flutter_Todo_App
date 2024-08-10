import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasked_app/theme/color.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';
import '../widgets/task_list.dart';
import 'package:google_fonts/google_fonts.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool isAddingTask = false;
  bool isListEmpty = true;
  bool isAddingSubtask = false;
  final TextEditingController taskController = TextEditingController();
  final TextEditingController subtaskController = TextEditingController();
  Task? selectedTask;

  void toggleAddTask() {
    setState(() {
      isAddingTask = !isAddingTask;
      isAddingSubtask = false;
      selectedTask = null;
    });
  }

  void toggleAddSubtask(Task task) {
    setState(() {
      isAddingSubtask = !isAddingSubtask;
      isAddingTask = false;
      selectedTask = task;
    });
  }

  void addTask(BuildContext context) {
    if (taskController.text.isNotEmpty) {
      Provider.of<TaskProvider>(context, listen: false)
          .addTask(Task(title: taskController.text));
      taskController.clear();
      toggleAddTask();
    } else {
      isListEmpty = true;
    }
  }

  void addSubtask(BuildContext context) {
    if (subtaskController.text.isNotEmpty && selectedTask != null) {
      Provider.of<TaskProvider>(context, listen: false)
          .addSubtask(selectedTask!, Task(title: subtaskController.text));
      subtaskController.clear();
      toggleAddSubtask(selectedTask!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 120, bottom: 40, left: 20),
                  child: Text(
                    'tasked',
                    style: GoogleFonts.aclonica(
                      color: Colors.white,
                      fontSize: 33,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            if (isAddingTask)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: tdBlack.withOpacity(.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: taskController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Yeni görev girin',
                            hintStyle: GoogleFonts.alata(
                              color: Colors.white.withOpacity(.6),
                              fontSize: 14,
                            ),
                          ),
                          onSubmitted: (_) => addTask(context),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () {
                        toggleAddTask();
                        taskController.clear();
                      },
                      color: tdGrey,
                    ),
                  ],
                ),
              ),
            if (isAddingSubtask)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: tdBlack.withOpacity(.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: subtaskController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Yeni alt görev girin',
                            hintStyle: GoogleFonts.alata(
                              color: Colors.white.withOpacity(.8),
                              fontSize: 14,
                            ),
                          ),
                          onSubmitted: (_) => addSubtask(context),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        toggleAddSubtask(selectedTask!);
                        subtaskController.clear();
                      },
                      color: tdGrey,
                    ),
                  ],
                ),
              ),
            Expanded(child: TaskList(toggleAddSubtask)),
          ],
        ),
        floatingActionButton: isAddingTask || isAddingSubtask
            ? FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: isAddingTask
                    ? () => addTask(context)
                    : () => addSubtask(context),
                child: Icon(
                  Icons.check,
                  size: 40,
                  color: tdBGColor,
                ),
                backgroundColor: tdRed,
              )
            : FloatingActionButton(
                focusColor: tdBlue,
                shape: CircleBorder(),
                onPressed: toggleAddTask,
                child: Icon(
                  Icons.add,
                  size: 40,
                  color: tdBGColor,
                ),
                backgroundColor: tdRed,
              ));
  }
}
