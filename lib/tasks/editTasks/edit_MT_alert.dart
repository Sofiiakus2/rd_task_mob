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
    TextEditingController titleController = TextEditingController(text:title );
    Size screenSize = MediaQuery.of(context).size;
    return  AlertDialog(
      title: const Center(
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
          margin: const EdgeInsets.only(top: 20),
          width: screenSize.width - 20,
          child: TextField(
            controller: titleController,
            style: const TextStyle(
              color: AppColors.black,
            ),
            cursorColor: Colors.black,
            decoration: const InputDecoration(
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
              if(titleController.text != title){
                Navigator.pop(context, titleController.text);
              }else{
                print('THERE NOT CHANGES');
              }

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
