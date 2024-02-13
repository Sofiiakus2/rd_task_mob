import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasker/personalProfile/profile_view.dart';
import 'package:tasker/tasks/addTask/add_new_task_view.dart';
import 'package:tasker/tasks/editTasks/edit_tasks_view.dart';
import 'package:tasker/tasks/monitoringTasks/monitoring_tasks_view.dart';
import 'package:tasker/tasks/tasks_full_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'chat/chats_page_view.dart';
import 'enter/entering/enter_view.dart';
import 'enter/registration/registration_view.dart';
import 'home/home_screen_view.dart';
import 'navigationBar/bottom_navigation_bar_view.dart';

void main() async{
  runApp(const Tasker());
}

class Tasker extends StatelessWidget {
  const Tasker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      routes: {
        "/":(context) => const BottomNavBar(),
        "/home":(context)=> const Home(),
        "/profile":(context)=>const Profile(),
        "/fullTasks":(context)=> FullTasks(),
        "/editTasks":(context)=> EditTasks(title: '', performer: '', date: '', progress: 0, result: '', miniTasks: [], assigner: '', assignees: [], completedTasks: [] ),
        "/addTasks":(context)=> AddNewTask(),
        "/monitoringTasks":(context)=> MonitoringTasks(),
        "/allChats": (context)=> ChatsPage(),
        "/registration":(context)=> Registration(),
        "/enter":(context)=> Enter(),


      },
      localizationsDelegates: <LocalizationsDelegate<Object>>[
        // ... app-specific localization delegate(s) here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: <Locale>[
        const Locale('uk', 'UA'),
        const Locale('en', 'US'), // English
         // German
        // ... other locales the app supports
      ],
    );
  }
}
