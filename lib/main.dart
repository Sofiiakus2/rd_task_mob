import 'package:firebase_core/firebase_core.dart';
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

      )
  );await FirebaseApi().initNotifications();
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
        "/editTasks":(context)=> const EditTasks(title: '', performer: '', date: '', progress: 0, result: '', miniTasks: [], assigner: '', assignees: [], completedTasks: [] ),
        "/addTasks":(context)=> const AddNewTask(),
        "/monitoringTasks":(context)=> MonitoringTasks(),
        "/allChats": (context)=> const ChatsPage(),
        "/registration":(context)=> const Registration(),
        "/enter":(context)=> const Enter(),


      },
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        // ... app-specific localization delegate(s) here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('uk', 'UA'),
        Locale('en', 'US'), // English
         // German
        // ... other locales the app supports
      ],
    );
  }
}
