import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/tasks/tasks.dart';
import 'dart:core';

class MonitoringTasks extends StatelessWidget {
  MonitoringTasks({super.key});
  final List<Task> tasks = [
    Task(
      title: 'Розробити сторінки',
      performer: 'Софія',
      date: '2024-02-10',
      progress: 0.3,
      result: 'Робоча програма зі всім робочим функціоналом',
      miniTasks: [
        'Сторінки вхід/реєстрація',
        'Сторінка редагувати задачу',
        'Сторінка чату',
        'Сторінки вхід/реєстрація',
        'Сторінка редагувати задачу',
        'Сторінка чату',

      ],
      assigner: 'Роман',

    ),
    Task(
      title: 'Ще якесь завдання',
      performer: 'Jane Smith',
      date: '2024-02-16',
      progress: 1,
      result: 'Виконане завдання',
      miniTasks: [
        'завдання'
      ], assigner: 'Олег',
    ),
    Task(
      title: 'Ще якесь завдання 3',
      performer: 'Jane Smith',
      date: '2024-02-16',
      progress: 1,
      result: 'Виконане завдання',
      miniTasks: [
        'завдання'
      ], assigner: 'Олег',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 10),

                      child: SizedBox(
                        width: 50,
                        child: FloatingActionButton(
                          heroTag: 'menu_button',
                          backgroundColor: AppColors.white,
                          splashColor: AppColors.grey,
                          elevation: 1.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          onPressed: () {},
                          tooltip: 'Floating Action Button',
                          child: const Icon(Icons.menu,
                            color: AppColors.black,
                            //size: 25,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20, top: 10),
                          child: SizedBox(
                            width: 50,
                            child: FloatingActionButton(
                              heroTag: 'bell_button',
                              backgroundColor: AppColors.white,
                              splashColor: AppColors.grey,
                              elevation: 1.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              onPressed: () {},
                              tooltip: 'Floating Action Button',
                              child: const Icon(CupertinoIcons.bell_fill,
                                color: AppColors.black,),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20, top: 10),
                          child: SizedBox(
                            width: 50,
                            child: FloatingActionButton(
                              heroTag: 'profile_button',
                              backgroundColor: AppColors.white,
                              splashColor: AppColors.grey,
                              elevation: 1.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/profile');
                              },
                              tooltip: 'Floating Action Button',
                              child: const Icon(Icons.person,
                                color: AppColors.black,),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 80),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Трекер\nзадач',
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),

              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              // color: AppColors.white, // Ви можете видалити цей рядок
              height: 3.5 * screenSize.height / 6,
              width: screenSize.width,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: tasks.isEmpty
                  ? Container(
                  height: 3 * screenSize.height / 5,
                  width: screenSize.width,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'У вас немає завдань',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ))
                  : Container(
                  height: 3 * screenSize.height / 5,
                  width: screenSize.width,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
                    child: ListView(
                      shrinkWrap: true,
                      children: [

                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            Widget trailingWidget;
                            final progressPercentage = (tasks[index].progress * 100).toStringAsFixed(0);

                            if (progressPercentage == '100') {
                              trailingWidget = const Icon(Icons.check, color: AppColors.black);
                            } else {
                              trailingWidget = Text(
                                '$progressPercentage%',
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                            return GestureDetector(
                              onTap: (){
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => EditTasksL(task: tasks[index]),
                                //   ),
                                // );
                              },
                              child: Column(
                                  children:[
                                    ListTile(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                                      leading: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: AppColors.grey.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(Icons.settings,
                                          color: AppColors.grey,),
                                      ),
                                      title: Text(tasks[index].title,
                                        style: const TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.bold
                                        ),),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(tasks[index].performer,),
                                          Text(tasks[index].date),

                                        ],
                                      ),
                                      trailing: trailingWidget,

                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: AppColors.grey.withOpacity(0.3),
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                  ]
                              ),
                            );

                          },

                        ),
                      ],
                    ),)
              ),
            ),
          ),
          Positioned(
            bottom: 3.5 * screenSize.height / 6.5,
            right: 40, // Змінено для центрування по горизонталі
            child: Container(
              // color: Colors.lightGreen,
              child: SvgPicture.asset(
                'assets/1.svg',
                width: screenSize.width/2,
                // height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
