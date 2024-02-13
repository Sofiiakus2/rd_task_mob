import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../chat/chats_page_view.dart';
import '../colors.dart';
import '../home/home_screen_view.dart';
import '../tasks/addTask/add_new_task_view.dart';
import '../tasks/tasks_full_view.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.task_outlined,
    Icons.chat_outlined,
    Icons.add_box_sharp,
  ];

  final screens = [
    const Home(),
    FullTasks(),
    const ChatsPage(),
    const AddNewTask(),

  ];

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: screenSize.height/11,
        itemCount: iconList.length,
        activeIndex: selectedIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 24,
        rightCornerRadius: 24,
        backgroundColor: AppColors.white,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        tabBuilder: (int index, bool isActive) {
          String label = '';
          switch (index) {
            case 0:
              label = 'Головна';
              break;
            case 1:
              label = 'Задачі';
              break;
            case 2:
              label = 'Чати';
              break;
            case 3:
              label = 'Додати';
              break;
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: screenSize.width / 15,
                color: isActive ? AppColors.grey : AppColors.black,
              ),
              SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  color: isActive ? AppColors.grey : AppColors.black,
                  fontSize: 12,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
