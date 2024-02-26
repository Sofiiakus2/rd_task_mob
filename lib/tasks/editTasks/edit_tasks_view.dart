import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tasker/tasks/editTasks/edit_MT_alert.dart';

import '../../colors.dart';
import '../../top_bar_view.dart';
import '../tasks.dart';

class EditTasks extends StatefulWidget {
  // final String title;
  // final String performer;
  // final String date;
  // final double progress;
  // final String result;
  // final List<String> miniTasks;
  // final String assigner;
  // final List<String>? assignees;
  // final List<bool> completedTasks;
  //
  // const EditTasks({
  //   Key? key,
  //   required this.title,
  //   required this.performer,
  //   required this.date,
  //   required this.progress,
  //   required this.result,
  //   required this.miniTasks,
  //   required this.assigner,
  //   required this.assignees,
  //   required this.completedTasks,
  // }) : super(key: key);

  @override
  State<EditTasks> createState() => _EditTasksState();
}

class _EditTasksState extends State<EditTasks> {
  late Task task;

  @override
  void initState() {
    task = Get.arguments[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<bool> completedTasks = List.generate(task.miniTasks.length, (_) => false);

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: [
            TopBar(),
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
                        task.title,
                        style: const TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text(
                        'Результат: ${task.result}',
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
                            Text(
                              task.performer,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.darkGrey,
                              ),
                            ),
                            Text(
                              'До ${task.date}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
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
                itemCount: task.miniTasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.transparent,
                    elevation: 0,
                    child: Dismissible(
                      key: Key(task.miniTasks[index]),
                      //direction: DismissDirection.endToStart,
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          Get.dialog(
                            EditMTAlert(),
                            arguments: [
                              task.miniTasks[index],
                            ],
                          );

                        } else {
                          return true;
                        }
                      },
                      onDismissed: (direction) {

                      },
                      background: Container(
                        margin: EdgeInsets.symmetric(horizontal: 35),
                        child: Row(
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
                        // alignment: Alignment.centerRight,
                        // margin: EdgeInsets.only(right: 20),
                        //
                      ),
                      child: Column(
                        children: [
                          CheckboxListTile(
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
                              task.miniTasks[index],
                              style: const TextStyle(
                                color: AppColors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            value: completedTasks[index],
                            onChanged: (bool? value) {
                              if (value != null) {
                                setState(() {
                                  completedTasks[index] = value;
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
              onPressed: () {
                Navigator.pop(context);
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
