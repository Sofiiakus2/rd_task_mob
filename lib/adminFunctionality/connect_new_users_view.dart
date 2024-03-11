import 'package:flutter/material.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/models/users.dart';
import 'package:tasker/navigationBar/top_bar_view.dart';

class ConnectUsers extends StatefulWidget {
  const ConnectUsers({super.key});

  @override
  _ConnectUsersState createState() => _ConnectUsersState();
}

class _ConnectUsersState extends State<ConnectUsers> with SingleTickerProviderStateMixin {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    List<User> users = getAllUsers() as List<User>;
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:AppColors.grey.withOpacity(0.3),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              children: [
                const TopBar(),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    'Ваші запити\nна приєднання до кімнати',
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                    ),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 3 * screenSize.height / 4,
              width: screenSize.width,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 80, left: 30, right: 30),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        //color: AppColors.grey.withOpacity(0.4),
                        decoration: BoxDecoration(
                          color: AppColors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(Icons.person,
                        size: 50,
                        color: AppColors.grey,),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              users.first.name,
                              style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                const Text(
                                  'Керівник ',
                                  style: TextStyle(
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400
                                  ),
                                ),
                                Checkbox(
                                  value: isSelected,
                                  activeColor: AppColors.black,
                                  onChanged: (value) {
                                    setState(() {
                                      isSelected = value!;
                                    });
                                  },
                                )

                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                          children: [
                            IconButton(
                                onPressed: (){

                                },
                                color: AppColors.black,
                                icon: const Icon(Icons.clear)),
                            IconButton(
                                onPressed: (){

                                },
                                color: AppColors.black,
                                icon: const Icon(Icons.check_outlined)),

                            // ElevatedButton(
                            //   onPressed: () {
                            //     //Navigator.pop(context);
                            //   },
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: AppColors.black,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(8.0), // Змінено на circular
                            //     ),
                            //     minimumSize: Size(30, 30),
                            //   ),
                            //   child: Text(
                            //     'v',
                            //     style: TextStyle(
                            //       color: AppColors.white,
                            //       fontSize: 18,
                            //       fontWeight: FontWeight.bold
                            //     ),
                            //   ),
                            // )


                          ],
                        ),

                    ],
                  ),
                ),
              )
            ),
          ),

        ],

      ),
    );
  }

}
