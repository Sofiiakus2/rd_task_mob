import 'package:flutter/material.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/tasks/tasks.dart';
import 'package:tasker/top_bar_view.dart';

import '../models/employee.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          children: [
            TopBar(),
            SizedBox(height: 30,),
            Container(
              height: 120,
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    //color: AppColors.grey.withOpacity(0.4),
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.person,
                      size: 50,
                      color: AppColors.grey,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${Employee.employees.first.name}',
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Успішно виконав завдання ${Task.tasks.where((element) => element.performer == Employee.employees.first.name).length} ',
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 120,
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    //color: AppColors.grey.withOpacity(0.4),
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.person,
                      size: 50,
                      color: AppColors.grey,),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${Employee.employees.last.name}',
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800
                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Успішно виконав завдання ${Task.tasks.where((element) => element.performer == Employee.employees.last.name).length} ',
                          style: TextStyle(
                              color: AppColors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
