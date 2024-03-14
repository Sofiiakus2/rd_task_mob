import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasker/chat/chat_screen_view.dart';
import 'package:tasker/personalProfile/profile_view.dart';
import 'package:tasker/tasks/addTask/add_new_task_view.dart';
import 'package:tasker/tasks/addTask/add_new_tasks.dart';
import 'package:tasker/tasks/editTasks/edit_tasks_view.dart';
import 'package:tasker/tasks/monitoringTasks/monitoring_tasks_view.dart';
import 'package:tasker/tasks/tasks_full_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tasker/adminFunctionality/connect_new_users_view.dart';

import 'adminFunctionality/appoint_department_for_user_view.dart';
import 'adminFunctionality/connect_and_appoint_view.dart';
import 'chat/chats_page_view.dart';
import 'commands/all_commands_view.dart';
import 'commands/connertToCommand/connect_command_view.dart';
import 'commands/createNewCommand/create_command_view.dart';
import 'enter/entering/enter_view.dart';
import 'enter/registration/registration_view.dart';
import 'firebase_api.dart';
import 'home/home_screen_view.dart';
import 'navigationBar/bottom_navigation_bar_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyBRka_S11U7YuY0vf1VR_LG8m1KOELkF9o',
        appId: '1:157931460120:android:28e5ac9b77919a4409956d',
        messagingSenderId: '157931460120',
        projectId: 'rd-tasks-mobi',
        storageBucket: 'rd-tasks-mobi.appspot.com',
      )
  );await FirebaseApi().initNotifications();
  runApp(const Tasker());
}

class Tasker extends StatelessWidget {
  const Tasker({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      routes: {
        "/":(context)=> const Enter(),
        "/bottomNavBar":(context) => const BottomNavBar(),
        "/home":(context)=> const Home(),
        "/profile":(context)=>const Profile(),
        "/fullTasks":(context)=> FullTasks(),
        "/editTasks":(context)=> const EditTasks(),
        "/addTasks":(context)=> const AddNewTask(),
        "/monitoringTasks":(context)=> MonitoringTasks(),
        "/allChats": (context)=> const ChatsPage(),
        "/registration":(context)=> const Registration(),
        "/enter":(context)=> const Enter(),
        "/connectUsers":(context)=> const AppointSwipeConnect(),
        "/chat":(context)=>const CurrentChat(),
        "/commands":(context)=>const AllCommands(),
        "/createCommand":(context)=>const CreateCommand(),
        "/connectCommand":(context)=>const ConnectCommand(),
       // "/appointDepartment":(context)=>AppointDepartment(),
       // "/reports":(context)=>Reports(),

      },
      // localizationsDelegates: const <LocalizationsDelegate<Object>>[
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: const <Locale>[
      //   Locale('uk', 'UA'),
      //   Locale('en', 'US'),
      // ],
    );
  }
}
