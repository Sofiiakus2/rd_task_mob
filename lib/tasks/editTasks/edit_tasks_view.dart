import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

class EditTasks extends StatefulWidget {
  final String title;
  final String performer;
  final String date;
  final double progress;
  final String result;
  final List<String> miniTasks;
  final String assigner;
  final List<String>? assignees;
  final List<bool> completedTasks;

  EditTasks({
    Key? key,
    required this.title,
    required this.performer,
    required this.date,
    required this.progress,
    required this.result,
    required this.miniTasks,
    required this.assigner,
    required this.assignees,
    required this.completedTasks,
  }) : super(key: key);

  @override
  State<EditTasks> createState() => _EditTasksState();
}

class _EditTasksState extends State<EditTasks> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
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
                      child: Icon(
                        Icons.menu,
                        color: AppColors.black,
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
                          child: Icon(
                            CupertinoIcons.bell_fill,
                            color: AppColors.black,
                          ),
                          tooltip: 'Floating Action Button',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
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
                          child: Icon(
                            Icons.person,
                            color: AppColors.black,
                          ),
                          tooltip: 'Floating Action Button',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              height: screenSize.height / 4,
              width: screenSize.width,
              color: AppColors.grey.withOpacity(0.2),
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.title,
                        style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        'Результат: ${widget.result}',
                        style: TextStyle(
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
                              widget.performer,
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.darkGrey,
                              ),
                            ),
                            Text(
                              'До ${widget.date}',
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.darkGrey,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            primary: AppColors.grey,
                            backgroundColor:
                            AppColors.grey.withOpacity(0.2),
                            side: BorderSide(color: AppColors.darkGrey),
                          ),
                          child: Text('Чат',
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
            SizedBox(height: 40),
            Expanded(
              child: ListView.builder(
                itemCount: widget.miniTasks.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      CheckboxListTile(
                        secondary: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            //color: AppColors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.settings,
                            color: AppColors.grey,
                          ),
                        ),
                        title: Text(
                          widget.miniTasks[index],
                          style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: widget.completedTasks[index],
                        onChanged: (bool? value) {
                          if (value != null) {
                            setState(() {
                              widget.completedTasks[index] = value;
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
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                primary: AppColors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
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
