import 'package:flutter/material.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/models/users.dart';

import '../models/organization.dart';
import 'connect_new_users.dart';

class AppointDepartment extends StatefulWidget {
  const AppointDepartment({super.key});

  @override
  _AppointDepartment createState() => _AppointDepartment();
}

class _AppointDepartment extends State<AppointDepartment> with SingleTickerProviderStateMixin {
  List<String>? selectedOrganization;


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
                        'Назначте відділи\nдля працівників',
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
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: getUsersWithoutDepartments(),
                      builder: (context, snapshot) {
                        List<Map<String, dynamic>>? userList = snapshot.data;
                        if (snapshot.data == null) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.black,
                            ),
                          );
                        }
                         if (userList != null && userList.isNotEmpty){
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
                            height: 3*screenSize.height/6,
                            width: screenSize.width,
                            child: ListView.builder(
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index){
                                  return Container(
                                    margin: const EdgeInsets.only(top: 20, left: 30, right: 30),
                                    height: 120,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                userList[index]['name'],
                                                style: const TextStyle(
                                                    color: AppColors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w800),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                width: 4*screenSize.width/5,
                                                height: 70,
                                                child: FutureBuilder<List<dynamic>>(
                                                    future: getOrganizationDepartments(),
                                                    builder: (context, snapshot) {
                                                      if (snapshot.data == null) {
                                                        return Center(
                                                          child: CircularProgressIndicator(
                                                            color: AppColors.black,
                                                          ),
                                                        );
                                                      }
                                                      selectedOrganization = List<String>.filled(userList!.length, snapshot.data?.first);
                                                      return DropdownButtonFormField<String>(
                                                        decoration: InputDecoration(
                                                          hintText: 'Відділи',
                                                          hintStyle: TextStyle(
                                                              fontSize: 20,
                                                              color: AppColors.grey
                                                          ),
                                                          focusedBorder: const OutlineInputBorder(
                                                            borderSide: BorderSide(color: AppColors.grey),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5), width: 1.5),
                                                            borderRadius: BorderRadius.circular(8.0),
                                                          ),
                                                        ),

                                                        value: selectedOrganization?[index],
                                                        onChanged: (newValue) {
                                                          setState(() {
                                                            selectedOrganization?[index] = newValue!;
                                                          });
                                                          print(userList[index]['id']);
                                                          updateDepartmentInOrganization(userList[index]['id'], selectedOrganization![index]);
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                              content: Text("Дані успішно оновлено"),
                                                              backgroundColor: AppColors.black,
                                                              duration: Duration(seconds: 1),
                                                            ),
                                                          );
                                                        },
                                                        items: snapshot.data!.map((department) {
                                                          return DropdownMenuItem<String>(
                                                            value: department,
                                                            child: Text(
                                                              department,
                                                              style: const TextStyle(
                                                                  fontSize: 20,
                                                                  color: AppColors.grey,
                                                                  fontWeight: FontWeight.w400
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      );
                                                    }
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  );
                                }),
                          );//

                        }
                        else{
                          return Container(
                            height: screenSize.height/2,
                            child: Center(
                                child: Text('Запитів немає')),
                          );
                        }
                      }
                  ),
                )
            ),
          ),

        ],

      ),
    );
  }

}
