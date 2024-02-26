import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/models/employee.dart';
import 'package:tasker/top_bar_view.dart';

class ConnectUsers extends StatefulWidget {
  @override
  _ConnectUsersState createState() => _ConnectUsersState();
}

class _ConnectUsersState extends State<ConnectUsers> with SingleTickerProviderStateMixin {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:AppColors.grey.withOpacity(0.3),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: [
                TopBar(),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Ваші запити\nна приєднання до кімнати',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 3 * screenSize.height / 4,
              width: screenSize.width,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 80, left: 30, right: 30),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        margin: EdgeInsets.only(top: 10),
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
                            Row(
                              children: [
                                Text(
                                  'Керівник ',
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Checkbox(
                                  value: isSelected,
                                  activeColor: AppColors.black,
                                  onChanged: (value) {
                                    setState(() {
                                      isSelected = value!;
                                    });
                                  },
                                )

                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                          children: [
                            IconButton(
                                onPressed: (){

                                },
                                color: AppColors.black,
                                icon: Icon(Icons.clear)),
                            IconButton(
                                onPressed: (){

                                },
                                color: AppColors.black,
                                icon: Icon(Icons.check_outlined)),

                            // ElevatedButton(
                            //   onPressed: () {
                            //     //Navigator.pop(context);
                            //   },
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: AppColors.black,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(8.0), // Змінено на circular
                            //     ),
                            //     minimumSize: Size(30, 30),
                            //   ),
                            //   child: Text(
                            //     'v',
                            //     style: TextStyle(
                            //       color: AppColors.white,
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.bold
                            //     ),
                            //   ),
                            // )


                          ],
                        ),

                    ],
                  ),
                ),
              )
            ),
          ),

        ],

        // child: Column(
        //   children: [
        //     TopBar(),

        //   ],
        // ),
      ),
    );
  }

}
