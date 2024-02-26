import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/top_bar_view.dart';

class CreateCommand extends StatefulWidget {
  const CreateCommand({super.key});

  @override
  State<CreateCommand> createState() => _CreateCommandState();
}

class _CreateCommandState extends State<CreateCommand> {
  double panelPosition = 0.0;
  double imagePosition = 0.0;
  double panelHeight = 400;

  final List<String> _items = ['Завдання 1'];
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Size screenSize = MediaQuery.of(context).size;
      panelPosition = -0.3 * screenSize.height;
      imagePosition = 0.65 * screenSize.height;
      panelHeight = screenSize.height;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            child: Column(
              children: [
                TopBar(),
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
                  height: 4 * screenSize.height / 6,
                  width: screenSize.width,
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
                              Column(
                                children: [
                                  // ListView.builder(
                                  //   shrinkWrap: true,
                                  //   physics: const NeverScrollableScrollPhysics(),
                                  //   itemCount: taskWidgets.length,
                                  //   itemBuilder: (context, index) {
                                  //     return Padding(
                                  //       padding: EdgeInsets.only(top: 0, bottom: 20),
                                  //       child: Row(
                                  //         children: [
                                  //
                                  //           Expanded(
                                  //             child: Container(
                                  //               decoration: BoxDecoration(
                                  //                   color: AppColors.grey.withOpacity(0.3),
                                  //                   borderRadius: BorderRadius.circular(6.0)
                                  //               ),
                                  //               child: TextField(
                                  //                 controller: taskWidgets[index],
                                  //                 decoration: InputDecoration(
                                  //                   suffixIcon: index == taskWidgets.length - 1
                                  //                       ? Row(
                                  //                     mainAxisSize: MainAxisSize.min,
                                  //                     children: [
                                  //                       IconButton(
                                  //                         onPressed: () {
                                  //                           setState(() {
                                  //                             taskWidgets.removeAt(index);
                                  //                           });
                                  //                         },
                                  //                         icon: const Icon(Icons.remove_circle_outline),
                                  //                       ),
                                  //                       IconButton(
                                  //                         onPressed: () {
                                  //                           setState(() {
                                  //                             taskWidgets.add(TextEditingController());
                                  //                           });
                                  //                         },
                                  //                         icon: const Icon(Icons.add_circle_outline),
                                  //                       ),
                                  //
                                  //                     ],
                                  //                   )
                                  //                       : IconButton(
                                  //                     onPressed: () {
                                  //                       setState(() {
                                  //                         taskWidgets.removeAt(index);
                                  //                       });
                                  //                     },
                                  //                     icon: const Icon(Icons.remove_circle_outline),
                                  //                   ),
                                  //                   hintText: 'Завдання',
                                  //                   hintStyle: const TextStyle(
                                  //                       fontSize: 16,
                                  //                       fontWeight: FontWeight.bold
                                  //                   ),
                                  //                   border: OutlineInputBorder(
                                  //                     borderRadius: BorderRadius.circular(6.0),
                                  //                     borderSide: BorderSide.none,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //
                                  //         ],
                                  //       ),
                                  //     );
                                  //   },
                                  // ),

                                  //ANIMATED LIST
                                  Container(
                                    height: MediaQuery.of(context).size.height/3 , // Фіксована висота для AnimatedList
                                    child: AnimatedList(
                                      key: _key,
                                      initialItemCount: _items.length,
                                      itemBuilder: (context, index, animation) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: SizeTransition(
                                            key: UniqueKey(),
                                            sizeFactor: animation,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: AppColors.grey.withOpacity(0.3),
                                                suffixIcon: index == taskWidgets.length - 1
                                                    ? Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _removeItem(index);
                                                        });
                                                      },
                                                      icon: const Icon(Icons.remove_circle_outline),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          _addItem();
                                                        });
                                                      },
                                                      icon: const Icon(Icons.add_circle_outline),
                                                    ),
                                                  ],
                                                )
                                                    : IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _removeItem(index);
                                                    });
                                                  },
                                                  icon: const Icon(Icons.remove_circle_outline),
                                                ),
                                                hintText: 'Відділ',
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
                                          ),
                                        );
                                      },
                                    ),
                                  ),



                                ],

                              ),
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
            bottom: 3.5 * screenSize.height / 5.7,
            right: 40,
            child: Container(
              child: SvgPicture.asset(
                'assets/1.svg',
                width: screenSize.width/2,
                // height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

