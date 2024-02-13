import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/tasks/tasks.dart';
import 'dart:core';

import 'editTasks/edit_tasks.dart';

class FullTasks extends StatelessWidget {
  FullTasks({super.key});
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
    Size screenSize = MediaQuery.of(context).size;
    tasks.sort((a, b) => DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));

    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20, top: 10),

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
                      child: Icon(Icons.menu,
                        color: AppColors.black,
                        //size: 25,
                      ),
                      tooltip: 'Floating Action Button',
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20, top: 10),
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
                          child: Icon(CupertinoIcons.bell_fill,
                            color: AppColors.black,),
                          tooltip: 'Floating Action Button',
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Container(
                      margin: EdgeInsets.only(bottom: 20, top: 10),
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
                          child: Icon(Icons.person,
                            color: AppColors.black,),
                          tooltip: 'Floating Action Button',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Перелік\nзадач',
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w500
                ),
              ),
            )
          ],
        ),
      ) ,
      bottomSheet: tasks.isEmpty
          ? Container(
          height: 3 * screenSize.height / 5,
          width: screenSize.width,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: Center(
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
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40.0),
            topRight: Radius.circular(40.0),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 50, left: 20, right: 20),
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
                  trailingWidget = Icon(Icons.check, color: AppColors.black);
                } else {
                  trailingWidget = Text(
                    '$progressPercentage%',
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTasksL(task: tasks[index]),
                      ),
                    );
                  },
                    child: Column(
                        children:[
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(vertical: 20),
                            leading: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                color: AppColors.grey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.settings,
                                color: AppColors.grey,),
                            ),
                            title: Text(tasks[index].title,
                              style: TextStyle(
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

    );

  }
}
