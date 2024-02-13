import 'package:flutter/material.dart';
import 'package:tasker/tasks/editTasks/edit_tasks_view.dart';

import '../tasks.dart';

class EditTasksL extends StatelessWidget {
  final Task task;

  const EditTasksL({Key? key, required this.task}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    List<bool> completedTasks = List.generate(task.miniTasks.length, (_) => false);

    return EditTasks(title: task.title,
      performer: task.performer,
      date: task.date,
      progress: task.progress,
      result: task.result,
      miniTasks: task.miniTasks,
      assigner: task.assigner,
      assignees: task.assignees,
      completedTasks: completedTasks,


    );
  }





}



