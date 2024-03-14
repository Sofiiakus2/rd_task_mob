
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasker/models/tasks.dart';
import 'package:tasker/tasks/addTask/add_v_alert.dart';


import '../../colors.dart';
import '../../models/users.dart';
import '../../navigationBar/top_bar_view.dart';
import 'add_s_alert.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  double panelPosition = -200.0;
  double imagePosition = 400.0;
  double panelHeight = 400;

  DateTime selectedDate = DateTime.now();
  List<TextEditingController> taskWidgets = [TextEditingController()];

  User? selectedPerformer;
  List<User> selectedWatchers =[] ;
  TextEditingController titleController = TextEditingController();
  TextEditingController resultController = TextEditingController();

  List<FocusNode> _focusNodes = [];

  @override
  void dispose() {
    for (var i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Size screenSize = MediaQuery.of(context).size;
      panelPosition = -0.42 * screenSize.height;
      imagePosition = 0.52 * screenSize.height;
      panelHeight = screenSize.height;
      for (var i = 0; i < taskWidgets.length; i++) {
        _focusNodes.add(FocusNode());
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                children: [
                  TopBar(),
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
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.only(top: 90, left: 20, right: 20),
                          child: Column(
                            children: [
                              TextField(
                                controller: titleController,
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
                                controller: resultController,
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
                                    padding: const EdgeInsets.only(top: 20.0),
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: taskWidgets.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: [

                                            Expanded(
                                              child: Container(
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
                                            onPressed: () async {
                                              final selectedUser = await showDialog<User>(
                                                context: context,
                                                builder: (context) => AddVAlert(),
                                              );

                                              if (selectedUser != null) {
                                                setState(() {
                                                  selectedPerformer = selectedUser;
                                                });
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(70, 55),
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
                                                selectedPerformer != null
                                                    ? Icon(Icons.done, color: AppColors.darkGrey)
                                                    : Icon(Icons.person_add_alt_1_outlined, color: AppColors.darkGrey),
                                              ],
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              final selectedUsers = await showDialog<List<User>>(
                                                context: context,
                                                builder: (context) => AddSAlert(),
                                              );

                                              if (selectedUsers != null) {
                                                setState(() {
                                                  selectedWatchers = selectedUsers;
                                                });
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: const Size(70, 55),
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
                                                if (selectedWatchers.isNotEmpty)
                                                  Icon(
                                                    Icons.check,
                                                    color: AppColors.darkGrey,
                                                    //size: 20,
                                                  ),
                                                if(selectedWatchers.isEmpty)
                                                  Icon(
                                                    Icons.people_alt_outlined,
                                                    color: AppColors.darkGrey,
                                                    //size: 20,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        ),


                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),

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
                                                  initialDateTime: selectedDate,
                                                  minimumDate: DateTime(2000),
                                                  maximumDate: DateTime(3000),
                                                  mode: CupertinoDatePickerMode.date,
                                                  onDateTimeChanged: (DateTime newDateTime) {
                                                    setState(() {
                                                      selectedDate = newDateTime;
                                                    });
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
                                      List<String> miniTasks = [];
                                      List<String> assigneesIds =[];
                                      if(taskWidgets.length ==1 &&taskWidgets.first.text.isEmpty){
                                        print('takssss');
                                      }else{
                                        for(var i in taskWidgets){
                                          miniTasks.add(i.text);
                                          //print(miniTasks);
                                        }
                                      }
                                      if(selectedWatchers.isEmpty){
                                        print('watchers');
                                      }else{
                                        for(var i in selectedWatchers)
                                        {
                                          assigneesIds.add(i.id);
                                        }
                                      }print('are you shure');
                                      if(selectedDate ==DateTime.now()){
                                        print('are you shure');
                                      }
                                      if(selectedDate.isBefore(DateTime.now())){
                                        print('погана дата');
                                      }

                                      if(titleController.text.isEmpty||titleController.text.isEmpty||taskWidgets.first.text.isEmpty||selectedPerformer==null){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text("Помилка"),
                                              content: Text("Недостатньо даних"),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: AppColors.black,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                    ),
                                                  ),
                                                  child: Text("OK",
                                                    style: TextStyle(color: AppColors.white),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }else{
                                        addNewTask(
                                          titleController.text,
                                          resultController.text,
                                          miniTasks,
                                          selectedPerformer!.id,
                                          selectedDate,
                                          assigneesIds: assigneesIds,
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text("Задачу успішно додано"),
                                            backgroundColor: AppColors.black,
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                        titleController.clear();
                                        resultController.clear();
                                        taskWidgets=[TextEditingController()];

                                      }
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

                            ],
                          ),
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
      ),
    );
  }
}