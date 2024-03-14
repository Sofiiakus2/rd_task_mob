import 'package:flutter/material.dart';

import '../../colors.dart';
import '../../models/organization.dart';
import '../../navigationBar/top_bar_view.dart';

class ConnectCommand extends StatefulWidget {
  const ConnectCommand({super.key});

  @override
  State<ConnectCommand> createState() => _ConnectCommandState();
}

class _ConnectCommandState extends State<ConnectCommand> {
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: [
            const TopBar(),
            Container(
              margin: const EdgeInsets.only(top: 40),
              alignment: Alignment.bottomLeft,
              child: const Text(
                'Доєднатися до кімнати',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.bottomLeft,
              child: const Text(
                'Для приєднання до чужої кімнати введіть запрошувальний код',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 40,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: codeController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.grey.withOpacity(0.3),
                  hintText: 'Запрошувальний код',
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 40,),
            ElevatedButton(
              onPressed: () {
                addUserIdToVerifierList(codeController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Очікуйте на під'єднання адміністратора"),
                    backgroundColor: AppColors.black,
                    duration: Duration(seconds: 1),
                  ),
                );
                Navigator.of(context).pushNamed('/commands');
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
                  'Доєднатися',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
