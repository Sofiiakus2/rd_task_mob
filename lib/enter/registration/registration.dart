import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../colors.dart';

class RegistrationPage extends StatelessWidget {
  final String username;
  final String password;

  const RegistrationPage({
    required this.username,
    required this.password,
    Key? key
  }): super(key: key);

  Future<void> writeUserData(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'name': username,
        'password': password,
      });

      Get.toNamed('/');
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Помилка'),
            content: const Text('Ми не змогли додати ваші дані',
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
      print('registration ERROR: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
