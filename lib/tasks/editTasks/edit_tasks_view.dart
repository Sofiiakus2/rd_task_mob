import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:tasker/models/users.dart';
import 'package:tasker/tasks/editTasks/edit_MT_alert.dart';
import 'package:intl/intl.dart';
import '../../colors.dart';
import '../../global_storage.dart';
import '../../models/tasks.dart';
import '../../navigationBar/top_bar_view.dart';


class EditTasks extends StatefulWidget {
  const EditTasks({super.key});


  @override
  State<EditTasks> createState() => _EditTasksState();
}

class _EditTasksState extends State<EditTasks> {

  final dynamic argument = Get.arguments;
  late String taskId;
  dynamic task;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (argument != null && argument.isNotEmpty) {
      task = argument[0];
      taskId = argument[1];
    }
    Timestamp timestamp = task['date'];
    DateTime date = timestamp.toDate();
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);

    List<dynamic> miniTasksList = task['miniTasks'];

    Map<String, bool> miniTasks = {};

    for (dynamic miniTask in miniTasksList) {
      if (miniTask is Map<String, dynamic> && miniTask.containsKey('name') && miniTask.containsKey('status')) {
        miniTasks[miniTask['name']] = miniTask['status'];
      }
    }

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: [
            const TopBar(),
            Container(
              margin: const EdgeInsets.only(top: 30),
              height: screenSize.height / 4,
              width: screenSize.width,
              color: AppColors.grey.withOpacity(0.2),
              child: Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        task['title'],
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Результат: ${task['result']}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FutureBuilder<User?>(
                              future: getUserById(task['performerId']),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.black,
                                    ),
                                  );
                                }
                                return Text(
                                  snapshot.data!.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.darkGrey,
                                  ),
                                );
                              }
                            ),
                            Text(
                              'До ${formattedDate}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        TextButton(//
                          onPressed: () async {
                            DocumentSnapshot<Map<String, dynamic>> organizationSnapshot = await FirebaseFirestore.instance
                                .collection('tasks')
                                .doc(taskId)
                                .get();

                            if (organizationSnapshot.exists && organizationSnapshot.data()!.containsKey('chat')) {
                                  Get.toNamed('/chat', arguments: [
                                    task,
                                  ]);
                            } else {
                              TextEditingController commentController = TextEditingController();

                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Чат відсутній'),
                                  content: SizedBox(
                                    height: screenSize.height / 5,
                                    child: Column(
                                      children: [
                                        Text('Бажаєте створити новий чат?\nЗалиште коментар, чат створиться автоматично'),
                                        SizedBox(height: 10),
                                        Container(
                                          child: TextField(
                                            controller: commentController,
                                            maxLines: 2,
                                            decoration: InputDecoration(
                                              hoverColor: AppColors.black,
                                              focusColor: AppColors.black,
                                              hintText: 'Введіть ваш коментар...',
                                              border: OutlineInputBorder(),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('Скасувати'),
                                    ),
                                    TextButton(
                                      //todo: add comment to chat
                                      onPressed: () async {
                                        if (commentController.text.isNotEmpty) {
                                          final messageId =randomAlphaNumeric(10);
                                          final time =DateTime.now();
                                          Map<String, dynamic> newChat = {
                                            'text': commentController.text,
                                            'messageId': messageId,
                                            'senderId': GlobalUserState.userId,
                                            'createdAt': time,
                                          };

                                          await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
                                            'chat': FieldValue.arrayUnion([
                                              {
                                                'text': commentController.text,
                                                'messageId': messageId,
                                                'senderId': GlobalUserState.userId,
                                                'createdAt': time,
                                              }
                                            ])
                                          });
                                          task['chat'] ??= [];
                                          task['chat'].add(newChat);
                                         Get.toNamed('/chat', arguments: [
                                            task,
                                         ]);
                                        } else {
                                          print('NOOO');
                                        }
                                      },

                                      child: Text('Створити'),
                                    ),
                                  ],
                                ),
                              );

                            }
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.grey, backgroundColor:
                            AppColors.grey.withOpacity(0.2),
                            side: const BorderSide(color: AppColors.darkGrey),
                          ),
                          child: const Text('Чат',
                          style: TextStyle(
                            color: AppColors.darkGrey
                          ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: miniTasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Dismissible(
                      key: Key(index.toString()),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          if (task != null && task['miniTasks'] != null) {
                            task['miniTasks'][index]['name'] = await Get.dialog(
                              const EditMTAlert(),
                              arguments: [
                                task['miniTasks'][index]['name'],
                              ],
                            );
                            setState(() {});
                          }
                          print(task['miniTasks'][index]['name']);
                        } else {
                          return true;
                        }
                        return null;
                      },

                      onDismissed: (direction) {

                      },
                      background: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 35),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.delete_forever_rounded,
                              color: AppColors.black,
                            ),
                            Icon(
                              Icons.edit,
                              color: AppColors.black,
                            ),

                          ],
                        )
                        //
                      ),
                      child: Column(
                        children: [
                          CheckboxListTile(
                            activeColor: AppColors.black,
                            secondary: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                //color: AppColors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.settings,
                                color: AppColors.grey,
                              ),
                            ),
                            title: Text(
                              task['miniTasks'][index]['name'],
                              style: const TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: task['miniTasks'][index]?['status'],
                            onChanged: (bool? value) {
                              if (value != null) {
                                setState(() {
                                  task['miniTasks'][index]?['status'] = value;

                                });
                              }
                            },
                          ),
                          Divider(
                            thickness: 1,
                            color: AppColors.grey.withOpacity(0.3),
                            indent: 20,
                            endIndent: 20,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                editMiniTasks(taskId,task['miniTasks']);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: const Text(
                  'Зберегти',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
