import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  List<TextEditingController> taskWidgets = [TextEditingController()];
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Додати\nзадачу',
                    style: TextStyle(
                        color: AppColors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.66,
            minChildSize: 0.66,
            maxChildSize: 1,
            builder: (BuildContext context, ScrollController scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 100, left: 20, right: 20),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.grey.withOpacity(0.3),
                            hintText: 'Назва',
                            hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.grey.withOpacity(0.3),
                            hintText: 'Результат',
                            hintStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: taskWidgets.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: 10),
                                              //height: 20,
                                              decoration: BoxDecoration(
                                                  color: AppColors.grey.withOpacity(0.3),
                                                  borderRadius: BorderRadius.circular(6.0)
                                              ),
                                              child: TextField(
                                                controller: taskWidgets[index],
                                                decoration: InputDecoration(
                                                  suffixIcon: index == taskWidgets.length - 1
                                                      ? Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            taskWidgets.removeAt(index);
                                                          });
                                                        },
                                                        icon: Icon(Icons.remove_circle_outline),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            taskWidgets.add(TextEditingController());
                                                          });
                                                        },
                                                        icon: Icon(Icons.add_circle_outline),
                                                      ),

                                                    ],
                                                  )
                                                      : IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        taskWidgets.removeAt(index);
                                                      });
                                                    },
                                                    icon: Icon(Icons.remove_circle_outline),
                                                  ),
                                                  //filled: true,
                                                  //fillColor: AppColors.grey.withOpacity(0.3),
                                                  hintText: 'Завдання',
                                                  hintStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(6.0),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                Container(
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(70, 55),
                                            backgroundColor: AppColors.buttonsGrey,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6.0),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Додати\nвиконавця',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.darkGrey,
                                                ),
                                              ),
                                              Icon(Icons.person_add_alt_1_outlined,
                                              color: AppColors.darkGrey,), // Ваша іконка
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(70, 55),
                                            backgroundColor: AppColors.buttonsGrey,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6.0),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Додати\nспостерігача',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.darkGrey,
                                                ),
                                              ),
                                              Icon(Icons.person_add_alt_1_rounded,
                                              color: AppColors.darkGrey,),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(minWidth: 50.0),
                                          margin: EdgeInsets.only(left: 30),
                                          padding: EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              "${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}",
                                              style: TextStyle(
                                                color: AppColors.darkGrey,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),


                                        ElevatedButton(
                                          onPressed: () async {

                                            final DateTime? dateTime = await showModalBottomSheet<DateTime>(
                                              context: context,
                                              builder: (BuildContext builder) {
                                                return Container(
                                                  height: MediaQuery.of(context).copyWith().size.height / 3,
                                                  child: CupertinoDatePicker(
                                                    initialDateTime: DateTime.now(),
                                                    minimumDate: DateTime(2000),
                                                    maximumDate: DateTime(3000),
                                                    mode: CupertinoDatePickerMode.date,

                                                    onDateTimeChanged: (DateTime newDateTime) {
                                                    },
                                                  ),
                                                );
                                              },
                                            );

                                            if (dateTime != null) {
                                              setState(() {
                                                selectedDate = dateTime;
                                              });
                                            }
                                          },

                                          // onPressed: () async{
                                          //   final DateTime? dateTime = await
                                          //   showDatePicker(
                                          //     context: context,
                                          //     firstDate: DateTime(2000),
                                          //     lastDate: DateTime(3000),
                                          //   );
                                          //   if(dateTime != null){
                                          //     setState(() {
                                          //       selectedDate = dateTime;
                                          //     });
                                          //   }
                                          // },
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(70, 55),
                                            primary: AppColors.buttonsGrey,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6.0),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Змінити дату',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.darkGrey,
                                                ),
                                              ),
                                              Icon(
                                                Icons.calendar_today,
                                                color: AppColors.darkGrey,
                                              ),
                                            ],
                                          ),
                                        )


                                      ],
                                    ),
                                SizedBox(height: 50),
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
                                      'Додати задачу',
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
                        ),


                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
