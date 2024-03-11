import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasker/global_storage.dart';

class Task {
  final String id;
  final String title;
  final String result;
  final List<Map<String, dynamic>> miniTasks;
  final String performerId;
  final String assignerId;
  final Map<String, dynamic> assigneesIds;
  final DateTime date;
  final int progress;
  final Map<String, dynamic> chat;

  Task({
    required this.id,
    required this.title,
    required this.result,
    required this.miniTasks,
    required this.performerId,
    required this.assignerId,
    required this.assigneesIds,
    required this.date,
    required this.progress,
    required this.chat,
  });

}

Future<void> editMiniTasks(String taskId, dynamic task) async{
  try{
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(taskId)
        .update({'miniTasks': task});


  }catch(e){
    print('EDIT MINI TASKS ERROR');
  }
}

Future<void> addNewTask(String title, String result, List<String> miniTasks, String performerId, DateTime selectedDate, {List<String>? assigneesIds}) async {

  List<Map<String, dynamic>> miniTasksList = [];

  for (String taskName in miniTasks) {
    Map<String, dynamic> miniTask = {
      'name': taskName,
      'status': false,
    };
    miniTasksList.add(miniTask);
  }

  Map<String, dynamic> taskData = {
    'title': title,
    'result': result,
    'miniTasks': miniTasksList,
    'performerId': performerId,
    'supervisorId': GlobalUserState.userId,
    'date': selectedDate != null ? Timestamp.fromDate(selectedDate) : null,
    'progress': 0,
    'roomId': GlobalOrganizationState.organizationId,
  };

  if (assigneesIds != null) {
    taskData['assigneesIds'] = assigneesIds;
  }
  await FirebaseFirestore.instance.collection('tasks').add(taskData);
}



