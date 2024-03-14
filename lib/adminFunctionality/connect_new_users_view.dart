import 'package:flutter/material.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/models/users.dart';

import 'connect_new_users.dart';

class ConnectUsers extends StatefulWidget {
  const ConnectUsers({super.key});

  @override
  _ConnectUsersState createState() => _ConnectUsersState();
}

class _ConnectUsersState extends State<ConnectUsers> with SingleTickerProviderStateMixin {

  List<bool> isCheckedList = List.filled(100, false);


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:AppColors.grey.withOpacity(0.3),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 90),
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                        'Ваші запити\nна приєднання до кімнати',
                        style: TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                    ),
                  ],
                ),
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
                    child: FutureBuilder<List<User>>(
                        future: getAllUnverifiedUsers(),
                        builder: (context, snapshot) {
                          List<User>? userList = snapshot.data;

                          if (userList != null && userList.isNotEmpty){
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 30),
                              height: 3*screenSize.height/6,
                              width: screenSize.width,
                              child: ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index){
                                    return Container(
                                      margin: const EdgeInsets.only(top: 80, left: 30, right: 30),
                                      height: 100,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            height: 80,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: AppColors.grey.withOpacity(0.4),
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: const Icon(
                                              Icons.person,
                                              size: 50,
                                              color: AppColors.grey,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(top: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  userList[index].name,
                                                  style: const TextStyle(
                                                      color: AppColors.black,
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w800),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      'Керівник ',
                                                      style: TextStyle(
                                                          color: AppColors.black,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w400),
                                                    ),
                                                    Checkbox(
                                                      value: isCheckedList[index],
                                                      activeColor: AppColors.black,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          isCheckedList[index] = value! ;
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
                                                  onPressed: () async {
                                                    setState(() {
                                                    });
                                                    await deleteUserFromoCurrentCommand(snapshot.data![index].id);
                                                    setState(() {
                                                      userList.removeAt(index);
                                                    });
                                                  },
                                                  color: AppColors.black,
                                                  icon: const Icon(Icons.clear)
                                              ),
                                              IconButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                    });
                                                    await addUserToCurrentCommand(snapshot.data![index].id, isCheckedList[index]);
                                                    setState(() {
                                                      userList.removeAt(index);
                                                    });
                                                  },
                                                  color: AppColors.black,
                                                  icon: const Icon(Icons.check_outlined)
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              ),
                            );
                          }
                          else{
                            return Container(
                              height: screenSize.height/2,
                              child: Center(
                                  child: Text('Запитів немає')
                              ),
                            );
                          }
                        }
                    ),
                  )
              )
          )
        ],
      ),
    );
  }
}
