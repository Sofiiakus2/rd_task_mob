import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double value1 = 0.4;
  double value2 = 0.7;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Container(
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
                          onPressed: () {
                            Navigator.of(context).pushNamed('/registration');
                          },
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
            Row(
              children: [
                Text('Вітаю, ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 30,
                      color: AppColors.black
                  ),),
                Text('Кароліна',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 30,
                      color: AppColors.black
                  ),)
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              alignment: Alignment.centerLeft,
                child: Text('Поточні задачі для вас',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black.withOpacity(0.3)
                ),)
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    width: screenSize.width/2 - 40,
                    height: screenSize.width/2 - 40,
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_box_outlined,
                          size: 35,
                          color: AppColors.black,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Додати задачу',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.black.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: screenSize.width/2 - 40,
                  height: screenSize.width/2 - 40,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Stack(
                      children: value1 < value2
                          ? [
                        CircularProgressIndicator(
                          backgroundColor: AppColors.white,
                          strokeCap: StrokeCap.round,
                          strokeWidth: 10,
                          strokeAlign: 6,
                          color: AppColors.black,
                          value: value2,
                        ),
                        CircularProgressIndicator(
                          strokeCap: StrokeCap.round,
                          strokeWidth: 10,
                          strokeAlign: 6,
                          color: Colors.red,
                          value: value1,
                        ),
                      ]
                          : [
                        CircularProgressIndicator(
                          backgroundColor: AppColors.white,
                          strokeCap: StrokeCap.round,
                          strokeWidth: 10,
                          strokeAlign: 6,
                          color: Colors.red,
                          value: value1,
                        ),
                        CircularProgressIndicator(
                         // backgroundColor: AppColors.white,
                          strokeCap: StrokeCap.round,
                          strokeWidth: 10,
                          strokeAlign: 6,
                          color: AppColors.black,
                          value: value2,
                        ),
                      ],
                    ),

                    //   CircularPercentIndicator(
                  //   radius: 65,
                  //   lineWidth: 8,
                  //   backgroundColor: AppColors.white,
                  //   progressColor: AppColors.black,
                  //     circularStrokeCap: CircularStrokeCap.round,
                  //     percent: 0.505,
                  //     center: Column(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         Text("50.5%",
                  //           style: TextStyle(
                  //             fontSize: 16,
                  //             color: AppColors.black,
                  //             fontWeight: FontWeight.w600
                  //           ),
                  //         ),
                  //         Text("прогрес",
                  //           style: TextStyle(
                  //               fontSize: 14,
                  //               color: AppColors.black.withOpacity(0.7),
                  //               fontWeight: FontWeight.w400
                  //           ),
                  //         ),
                  //       ],
                  //     )
                  // ),
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                    color: AppColors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
              margin: EdgeInsets.only(top: 20),
              height: 80,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Icon(
                    Icons.list,
                    size: 30,
                    color: AppColors.black,
                  ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      'Всі мої задачі',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  IconButton(
                    icon: Icon(Icons.navigate_next, color: AppColors.black),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(top: 20),
              height: 80,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Icon(
                      Icons.check_circle_outline,
                      size: 30,
                      color: AppColors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      'Задачі для мене',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  IconButton(
                    icon: Icon(Icons.navigate_next, color: AppColors.black),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: (){

                Navigator.of(context).pushNamed('/monitoringTasks');
              },
              child: Container(
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(top: 20),
              height: 80,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Icon(
                      Icons.remove_red_eye_outlined,
                      size: 30,
                      color: AppColors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      'Стежу',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  IconButton(
                    icon: Icon(Icons.navigate_next, color: AppColors.black),
                    onPressed: () {

                    },
                  ),
                ],
              ),
            ),),
            Container(
              decoration: BoxDecoration(
                color: AppColors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(top: 20),
              height: 80,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Icon(
                      Icons.people_alt_outlined,
                      size: 30,
                      color: AppColors.black,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30),
                    child: Text(
                      'Мої команди',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.navigate_next, color: AppColors.black),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

          ],
        ),
      ),)

    );
  }
}
