import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/commands/createNewCommand/create_command.dart';
import 'package:tasker/navigationBar/top_bar_view.dart';

class CreateCommand extends StatefulWidget {
  const CreateCommand({super.key});

  @override
  State<CreateCommand> createState() => _CreateCommandState();
}

class _CreateCommandState extends State<CreateCommand> {


  List<String> departments = [];
  TextEditingController nameController = TextEditingController();

  final List<String> _items = ['Віддід 1'];
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  List<TextEditingController> taskWidgets = [TextEditingController()];

  void _addItem() {
    _items.insert(0, "Відділ");
    _key.currentState!.insertItem(
      0,
      duration: const Duration(seconds: 1),
    );
    setState(() {
      departments.add('');
    });
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
                       //
                        taskWidgets.removeAt(index);
                        departments.removeAt(index);
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
  List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Size screenSize = MediaQuery.of(context).size;
      for (var i = 0; i < taskWidgets.length; i++) {
        _focusNodes.add(FocusNode());
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    for (var i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
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
                    const TopBar(),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Створити\nкоманду',
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
                  height: 4 * MediaQuery.of(context).size.height / 6,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                        ),
                      ),
                      child: Container(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
                              child: Column(
                                children: [
                                  TextField(
                                    controller: nameController,
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
                                  const SizedBox(height: 20),
                                  Column(
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: taskWidgets.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(top: 0, bottom: 20),
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
                                                                  departments.removeAt(index);
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
                                                        hintText: 'Відділ',
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
          
                                   //   ANIMATED LIST
                                   //    Container(
                                   //      height: MediaQuery.of(context).size.height/3 , // Фіксована висота для AnimatedList
                                   //      child: AnimatedList(
                                   //        key: _key,
                                   //        initialItemCount: _items.length,
                                   //        itemBuilder: (context, index, animation) {
                                   //          return Padding(
                                   //            padding: const EdgeInsets.symmetric(vertical: 8.0),
                                   //            child: SizeTransition(
                                   //              key: UniqueKey(),
                                   //              sizeFactor: animation,
                                   //              child: TextField(
                                   //                onChanged: (value){
                                   //                  setState(() {
                                   //                    departments[index]=value;
                                   //                  });
                                   //                },
                                   //                decoration: InputDecoration(
                                   //                  filled: true,
                                   //                  fillColor: AppColors.grey.withOpacity(0.3),
                                   //                  suffixIcon: index == taskWidgets.length - 1
                                   //                      ? Row(
                                   //                    mainAxisSize: MainAxisSize.min,
                                   //                    children: [
                                   //                      IconButton(
                                   //                        onPressed: () {
                                   //                          setState(() {
                                   //                            _removeItem(index);
                                   //                          });
                                   //                        },
                                   //                        icon: const Icon(Icons.remove_circle_outline),
                                   //                      ),
                                   //                      IconButton(
                                   //                        onPressed: () {
                                   //                          setState(() {
                                   //                            _addItem();
                                   //                          });
                                   //                        },
                                   //                        icon: const Icon(Icons.add_circle_outline),
                                   //                      ),
                                   //                    ],
                                   //                  )
                                   //                      : IconButton(
                                   //                    onPressed: () {
                                   //                      setState(() {
                                   //                        _removeItem(index);
                                   //                      });
                                   //                    },
                                   //                    icon: const Icon(Icons.remove_circle_outline),
                                   //                  ),
                                   //                  hintText: 'Відділ',
                                   //                  hintStyle: const TextStyle(
                                   //                    fontSize: 16,
                                   //                    fontWeight: FontWeight.bold,
                                   //                  ),
                                   //                  border: OutlineInputBorder(
                                   //                    borderRadius: BorderRadius.circular(6.0),
                                   //                    borderSide: BorderSide.none,
                                   //                  ),
                                   //                ),
                                   //              ),
                                   //            ),
                                   //          );
                                   //        },
                                   //      ),
                                   //    ),
          
          
          
                                    ],
          
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      for(TextEditingController task in taskWidgets){
                                          departments.add(task.text);
                                      }
                                      CreateOrganization createOrganization = CreateOrganization(name: nameController.text, departments: departments);
                                      createOrganization.writeOrganizationData();
                                      createOrganization.addOrUpdateOrganizationToUser();
                                      Navigator.pushNamed(context, '/bottomNavBar');
                                     // Navigator.pop(context);
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
                                        'Створити',
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),)
                  ),
                ),
              Positioned(
                bottom: 3.5 * MediaQuery.of(context).size.height / 5.7,
                right: 40,
                child: Container(
                  child: SvgPicture.asset(
                    'assets/1.svg',
                    width: MediaQuery.of(context).size.width/2,
                    // height: 100,
                  ),
                ),
              ),
            ],
          ),
        ),

    );
  }
}


