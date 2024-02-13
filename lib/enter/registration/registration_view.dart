import 'package:flutter/material.dart';

import '../../colors.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
         child:Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Реєстрація',
            style: TextStyle(
              color: AppColors.grey,
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),),
            const SizedBox(height: 60,),
            const Text('RD Tasks',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 26,
              fontWeight: FontWeight.w900
            ),),
            const SizedBox(height: 60,),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText: 'Телефон',
                hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: AppColors.grey,
                    width: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                filled: true,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.remove_red_eye_outlined,
                  color: AppColors.grey,),
                  onPressed: () {  },
                ),
                fillColor: AppColors.white,
                hintText: 'Пароль',
                hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.grey
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: AppColors.grey,
                    width: 0.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60,),
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
                  'Зареєструватися',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/enter");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonsGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Container(
                width: 160,
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: const Center(
                  child: Text(
                  'Увійти',
                  style: TextStyle(
                    color: AppColors.darkGrey,
                    fontSize: 18,
                  ),
                ),)
              ),
            ),
          ],
        ),)
      ),
    );
  }
}
