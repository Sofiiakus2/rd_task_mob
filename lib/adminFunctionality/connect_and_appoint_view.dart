import 'package:flutter/material.dart';
import 'package:tasker/colors.dart';

import '../navigationBar/top_bar_view.dart';
import 'appoint_department_for_user_view.dart';
import 'connect_new_users_view.dart';

class AppointSwipeConnect extends StatelessWidget {
  const AppointSwipeConnect({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:AppColors.grey.withOpacity(0.1),

      body: PageView(
        children: [
          ConnectUsers(),
          AppointDepartment(),
        ],
      ),
    );
  }
}
