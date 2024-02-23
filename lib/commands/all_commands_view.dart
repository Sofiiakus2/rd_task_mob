import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../colors.dart';
import '../top_bar_view.dart';

class AllCommands extends StatelessWidget {
  const AllCommands({super.key});

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
              TopBar(),
              Container(
                margin: EdgeInsets.only(top: 40),
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Мої кімнати',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                height: screenSize.height/8,
                width: screenSize.width,
                //color: Colors.amber,
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    Container(
                      height: screenSize.height/10,
                      width: screenSize.height/10,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:  AppColors.grey.withOpacity(0.3),
                      ),
                      child: Icon(Icons.people_outline_outlined,
                      color: AppColors.grey,
                      size: 40,),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(left: 30, top: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:
                          [
                            Text('Робота',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.black
                              ),
                            ),
                            Text('Адмін',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.grey
                              ),
                            ),
                          ]
                        )
                    ),
                  ],
                ),
              ),
              Container(
                height: screenSize.height/8,
                width: screenSize.width,
                //color: Colors.amber,
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  children: [
                    Container(
                      height: screenSize.height/10,
                      width: screenSize.height/10,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color:  AppColors.grey.withOpacity(0.3),
                      ),
                      child: Icon(Icons.people_outline_outlined,
                        color: AppColors.grey,
                        size: 40,),
                    ),
                    Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(left: 30, top: 25),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                              Text('Дім',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black
                                ),
                              ),
                              Text('Субадмін',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.grey
                                ),
                              ),
                            ]
                        )
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
