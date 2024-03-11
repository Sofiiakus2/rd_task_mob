import 'package:flutter/material.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/models/users.dart';

import '../../models/organization.dart';




class AddSAlert extends StatefulWidget {
  AddSAlert({Key? key}) : super(key: key);

  @override
  State<AddSAlert> createState() => _AddVAlertState();
}

class _AddVAlertState extends State<AddSAlert> {
  List<User> selectedItems = [];

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
          'Додати спостерігачів',
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
            padding: EdgeInsets.all(10),
            child: FutureBuilder<List<dynamic>>(
              future: getOrganizationDepartments(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for (String department in snapshot.data!)
                        FutureBuilder<List<User>>(
                          future: getUsersInOrganization(department),
                          builder: (context, usersSnapshot) {
                            if (usersSnapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            List<User> users = usersSnapshot.data!;
                            return Column(
                              children: users.map((users){
                                return ExpansionTile(
                                    title: selectedItems.any((item) => item.organizations != null && item.organizations!.any((org) => org['department'] == department))
                                    ? Wrap(
                                      children: selectedItems
                                          .where((element) => element.organizations != null)
                                          .expand((element) => element.organizations!)
                                          .where((org) => org['department'] == department)
                                          .map((org) {
                                        User user = selectedItems.firstWhere((item) => item.organizations!.any((o) => o['department'] == department));
                                        return Chip(
                                          backgroundColor: AppColors.grey.withOpacity(0.3),
                                          labelStyle: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.darkGrey,
                                          ),
                                          label: Text('${user.name}'),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                            side: BorderSide(
                                              color: AppColors.grey.withOpacity(0.3),
                                              width: 0,
                                            ),
                                          ),
                                        );
                                      })
                                          .toList(),
                                    )
                                    :Text(
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
                                          }
                                          else if (usersSnapshot.hasData) {
                                            List<User> users = usersSnapshot.data!;

                                            return Column(
                                              children: users.map((user) {
                                                return ListTile(
                                                  title: Text(
                                                    user.name,
                                                    style: TextStyle(
                                                      fontWeight: selectedItems.any((item) => item.name == user.name)
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,

                                                    ),
                                                  ),
                                                  onTap: () {
                                                    setState(() {
                                                      if (selectedItems.any((item) => item.id == user.id)) {
                                                        selectedItems.removeWhere((item) => item.id == user.id);
                                                      } else {
                                                        selectedItems.add(user);
                                                      }


                                                      //selectedItems.add(user);

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
                                );
                              }).toList(),
                            );

                          }
                        ),
                    ],
                  ),
                );

              }
            ),
          ),


      actions: [
        ElevatedButton(
          onPressed: () {
            if (selectedItems.isNotEmpty) {
              Navigator.pop(context, selectedItems);
            } else {
              print('ОБЕРІТЬ СПОСТЕРІГАЧА (ADD_S_ALERT)');
            }
            //Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: const Text(
              'Додати',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
