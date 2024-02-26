import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasker/colors.dart';

class EditMTAlert extends StatefulWidget {
  const EditMTAlert({super.key});

  @override
  State<EditMTAlert> createState() => _EditMTAlertState();
}

class _EditMTAlertState extends State<EditMTAlert> {
  late String title;

  @override
  void initState(){
    title = Get.arguments[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return  AlertDialog(
      title: Center(
        child: Text(
          'Редагувати підзадачу',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
        content: Container(
          margin: EdgeInsets.only(top: 20),
          width: screenSize.width - 20,
          //height: screenSize.height / 2,
          child: TextField(
            controller: TextEditingController(text: title),
            style: TextStyle(
              color: AppColors.black,
            ),
            cursorColor: Colors.black, // Встановлення коліру курсору
            decoration: InputDecoration(
              // Настройка контуру
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
        actions: [
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
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: const Text(
                'Зберегти',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],

    );
  }
}
