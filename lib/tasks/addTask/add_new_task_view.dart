import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasker/tasks/addTask/add_v_alert.dart';


import '../../colors.dart';
import '../SelectedEmployee.dart';
import 'add_new_tasks.dart';
import 'add_s_alert.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({super.key});

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  double panelPosition = 0.0;
  double imagePosition = 0.0;
  double panelHeight = 400;

  DateTime selectedDate = DateTime.now();
  final List<String> _items = ['Завдання 1']; // Початковий елемент списку
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<TextEditingController> taskWidgets = [TextEditingController()];


  void _addItem() {
    _items.insert(0, "Завдання");
    _key.currentState!.insertItem(
      0,
      duration: const Duration(seconds: 1),
    );
  }

  void _removeItem(int index) {
    _key.currentState!.removeItem(
      index,
          (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: TextField(
            //controller: taskWidgets[index],
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
                    icon: const Icon(Icons.remove_circle_outline),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        taskWidgets.add(TextEditingController());
                      });
                    },
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              )
                  : IconButton(
                onPressed: () {
                  setState(() {
                    taskWidgets.removeAt(index);
                  });
                },
                icon: const Icon(Icons.remove_circle_outline),
              ),
              //filled: true,
              //fillColor: AppColors.grey.withOpacity(0.3),
              hintText: 'Завдання',
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        );
      },
      duration: const Duration(milliseconds: 300),
    );
    _items.removeAt(index);
  }


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // Initialize panelPosition and imagePosition after the first frame has been built
      Size screenSize = MediaQuery.of(context).size;
      panelPosition = -0.42 * screenSize.height;
      imagePosition = 0.52 * screenSize.height;
      panelHeight = screenSize.height;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(30),
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
                          child: const Icon(
                            Icons.menu,
                            color: AppColors.black,
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
                              child: const Icon(
                                CupertinoIcons.bell_fill,
                                color: AppColors.black,
                              ),
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
                              child: const Icon(
                                Icons.person,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.centerLeft,
                  child: const Text(
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
          Positioned(
              bottom: panelPosition,
              left: 0,
              right: 0,
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  setState(() {
                    panelPosition -= details.delta.dy;

                    imagePosition -= details.delta.dy;

                    if (panelPosition > 0.001 *screenSize.height) {
                      panelPosition =  0.001 *screenSize.height;
                      imagePosition = 0.94 * screenSize.height;

                    } else if (panelPosition > panelHeight) {
                      panelPosition = panelHeight;
                    }else if (panelPosition < -0.42 * screenSize.height) {
                      panelPosition = -0.42 * screenSize.height;
                      imagePosition = 0.52 * screenSize.height;
                    }

                  });
                },
                child: Container(
                    height: screenSize.height,
                    width: screenSize.width,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(top: 90, left: 20, right: 20),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.grey.withOpacity(0.3),
                              hintText: 'Назва',
                              hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: AppColors.grey.withOpacity(0.3),
                              hintText: 'Результат',
                              hintStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: taskWidgets.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 0, bottom: 20),
                                    child: Row(
                                      children: [

                                        Expanded(
                                          child: Container(
                                            //padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                                      icon: const Icon(Icons.remove_circle_outline),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          taskWidgets.add(TextEditingController());
                                                        });
                                                      },
                                                      icon: const Icon(Icons.add_circle_outline),
                                                    ),

                                                  ],
                                                )
                                                    : IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      taskWidgets.removeAt(index);
                                                    });
                                                  },
                                                  icon: const Icon(Icons.remove_circle_outline),
                                                ),
                                                //filled: true,
                                                //fillColor: AppColors.grey.withOpacity(0.3),
                                                hintText: 'Завдання',
                                                hintStyle: const TextStyle(
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
                              SizedBox(
                                height: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context)=>AddVAlert(),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(70, 55),
                                          backgroundColor: AppColors.buttonsGrey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                        ),
                                        child: const Row(
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
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context)=>AddSAlert(),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(70, 55),
                                          backgroundColor: AppColors.buttonsGrey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6.0),
                                          ),
                                        ),
                                        child: const Row(
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
                              const SizedBox(height: 20),
                              // Container(
                              //   height: MediaQuery.of(context).size.height , // Фіксована висота для AnimatedList
                              //   child: AnimatedList(
                              //     key: _key,
                              //     initialItemCount: _items.length,
                              //     itemBuilder: (context, index, animation) {
                              //       return Padding(
                              //         padding: const EdgeInsets.symmetric(vertical: 8.0),
                              //         child: SizeTransition(
                              //           key: UniqueKey(),
                              //           sizeFactor: animation,
                              //           child: TextField(
                              //             decoration: InputDecoration(
                              //               filled: true,
                              //               fillColor: AppColors.grey.withOpacity(0.3),
                              //               suffixIcon: index == taskWidgets.length - 1
                              //                   ? Row(
                              //                 mainAxisSize: MainAxisSize.min,
                              //                 children: [
                              //                   IconButton(
                              //                     onPressed: () {
                              //                       setState(() {
                              //                         _removeItem(index);
                              //                       });
                              //                     },
                              //                     icon: const Icon(Icons.remove_circle_outline),
                              //                   ),
                              //                   IconButton(
                              //                     onPressed: () {
                              //                       setState(() {
                              //                         _addItem();
                              //                       });
                              //                     },
                              //                     icon: const Icon(Icons.add_circle_outline),
                              //                   ),
                              //                 ],
                              //               )
                              //                   : IconButton(
                              //                 onPressed: () {
                              //                   setState(() {
                              //                     _removeItem(index);
                              //                   });
                              //                 },
                              //                 icon: const Icon(Icons.remove_circle_outline),
                              //               ),
                              //               hintText: 'Завдання',
                              //               hintStyle: const TextStyle(
                              //                 fontSize: 16,
                              //                 fontWeight: FontWeight.bold,
                              //               ),
                              //               border: OutlineInputBorder(
                              //                 borderRadius: BorderRadius.circular(6.0),
                              //                 borderSide: BorderSide.none,
                              //               ),
                              //             ),
                              //           ),
                              //         ),
                              //       );
                              //     },
                              //   ),
                              // ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    constraints: const BoxConstraints(minWidth: 50.0),
                                    margin: const EdgeInsets.only(left: 30),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        "${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}",
                                        style: const TextStyle(
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
                                          return SizedBox(
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
                                      minimumSize: const Size(70, 55), backgroundColor: AppColors.buttonsGrey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6.0),
                                      ),
                                    ),
                                    child: const Row(
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
                              const SizedBox(height: 30),
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

                          // Column(
                          //     children:[
                          //       Expanded(
                          //         child: AnimatedList(
                          //           key: _key,
                          //           initialItemCount: _items.length,
                          //           itemBuilder: (context, index, animation) {
                          //             return Padding(
                          //               //padding: EdgeInsets.only(bottom: 20),
                          //               padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust the vertical spacing here
                          //               child: SizeTransition(
                          //                 key: UniqueKey(),
                          //                 sizeFactor: animation,
                          //                 child: TextField(
                          //                   //controller: taskWidgets[index],
                          //                   decoration: InputDecoration(
                          //                     filled: true,
                          //                     fillColor: AppColors.grey.withOpacity(0.3),
                          //                     suffixIcon: index == taskWidgets.length - 1
                          //                         ? Row(
                          //                       mainAxisSize: MainAxisSize.min,
                          //                       children: [
                          //                         IconButton(
                          //                           onPressed: () {
                          //                             setState(() {
                          //                               _removeItem(index);
                          //                             });
                          //                           },
                          //                           icon: const Icon(Icons.remove_circle_outline),
                          //                         ),
                          //                         IconButton(
                          //                           onPressed: () {
                          //                             setState(() {
                          //                               _addItem();
                          //                             });
                          //                           },
                          //                           icon: const Icon(Icons.add_circle_outline),
                          //                         ),
                          //                       ],
                          //                     )
                          //                         : IconButton(
                          //                       onPressed: () {
                          //                         setState(() {
                          //                           _removeItem(index);
                          //                         });
                          //                       },
                          //                       icon: const Icon(Icons.remove_circle_outline),
                          //                     ),
                          //                     hintText: 'Завдання',
                          //                     hintStyle: const TextStyle(
                          //                       fontSize: 16,
                          //                       fontWeight: FontWeight.bold,
                          //                     ),
                          //                     border: OutlineInputBorder(
                          //                       borderRadius: BorderRadius.circular(6.0),
                          //                       borderSide: BorderSide.none,
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ),
                          //             );
                          //           },
                          //         ),),
                          //     ]
                          // ),

                        ],
                      ),
                    )
                ),
              )

          ),
          Positioned(
            bottom: imagePosition,
            left: MediaQuery.of(context).size.width / 2.5,
            child: Container(
              child: SvgPicture.asset(
                'assets/3.svg',
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
