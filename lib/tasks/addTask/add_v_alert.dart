
import 'package:flutter/material.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/models/users.dart';

import '../../models/organization.dart';


class AddVAlert extends StatefulWidget {
  AddVAlert({Key? key}) : super(key: key);

  @override
  State<AddVAlert> createState() => _AddVAlertState();
}

class _AddVAlertState extends State<AddVAlert> {
  User? selectedUser;

  late List<User> users;
  late List<Organization> organizations;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      title: Center(
        child: Text(
          'Додати виконавця\n${selectedUser?.name ?? ''}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      content: Container(
        width: screenSize.width - 20,
        height: screenSize.height / 2,
        child: FutureBuilder<List<dynamic>>(
          future: getOrganizationDepartments(),
          builder: (context, snapshot) {
            print(snapshot);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    for (String department in snapshot.data!)
                      ExpansionTile(
                        title: Text(
                          department,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        children: [
                          FutureBuilder<List<User>>(
                            future: getUsersInOrganization(department),
                            builder: (builder, usersSnapshot){
                              if (usersSnapshot.connectionState == ConnectionState.waiting) {
                                return Center(child: CircularProgressIndicator());
                              } else if (usersSnapshot.hasData) {
                                List<User> users = usersSnapshot.data!;
                                return Column(
                                  children: users.map((user) {
                                    return ListTile(
                                      title: Text(
                                         user.name,
                                        style: TextStyle(
                                          fontWeight: selectedUser?.name == user.name
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          selectedUser = user;
                                        });
                                      },
                                    );
                                  }).toList(),
                                );
                              } else {
                                return Center(child: Text('No users available'));
                              }
                            },
                          ),
                        ]
                      ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),



      ),

      actions: [
        ElevatedButton(
          onPressed: () {
            //getOrganizationDepartments();
            if (selectedUser != null) {
              Navigator.pop(context, selectedUser);
            } else {
              print('ОБЕРІТЬ ВИКОНАВЦЯ (ADD_V_ALERT)');
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: const Text(
              'Додати',
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