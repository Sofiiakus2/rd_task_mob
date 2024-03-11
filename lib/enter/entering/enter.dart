
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/global_storage.dart';

class EnterPage extends StatelessWidget{
  final String username;
  final String password;

  const EnterPage({
    required this.username,
    required this.password,
    Key? key
  }): super(key: key);

  Future<void> signIn(BuildContext context) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('users')
          .where('name', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        GlobalUserState.userId = querySnapshot.docs.first.id;
        saveUserName(username);
       // getTasks();
        checkUserFieldExistence();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Помилка'),
              content: const Text('Невірно вказаний телефон або пароль',
              style: TextStyle(fontSize: 16),),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK',
                  style: TextStyle(
                    color: AppColors.black
                  ),),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('entering ERROR: $e');
    }
  }

  Future<void> checkUserFieldExistence() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(GlobalUserState.userId).get();
      if (userDoc.exists) {
        Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
        if (userData != null && userData.containsKey('organizations')) {
          dynamic organizationsData = userData['organizations'];
          if (organizationsData.length > 1) {
            Get.toNamed('/commands');
          } else if(organizationsData.length == 1) {
            GlobalOrganizationState.organizationId =organizationsData[0]['id'];
            Get.toNamed('/bottomNavBar');
          }
        } else {
          Get.toNamed('/createCommand');
        }
      } else {
        print('Документ користувача не існує(ENTER)');
      }
    } catch (e) {
      // Помилка запиту до бази даних
      print('Помилка()ENTER: $e');
    }
  }

  Future<void> saveUserName(String userName) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
  }





  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }



}
