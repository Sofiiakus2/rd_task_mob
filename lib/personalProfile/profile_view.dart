import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasker/colors.dart';

import '../models/users.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? selectedOrganization;
  String? name;
  String? position;



  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.navigate_before, color: AppColors.grey, size:30,),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.white,
        title: const Text(
          'Профіль',
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.white,
          margin: const EdgeInsets.all(30),
          child: FutureBuilder<User?>(
            future: getCurrentUser(),
            builder: (context, snapshotUser) {
              if (snapshotUser.hasError) {
                return Text('Error: ${snapshotUser.error}');
              }
              if (snapshotUser.data == null) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.black,
                    ),
                  );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                          width: screenSize.width/5,
                          height: screenSize.width/5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.grey.withOpacity(0.3),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.perm_identity,
                              color: AppColors.grey,
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Телефон',
                            labelStyle: const TextStyle(
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
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50,),
                  Container(
                    child: TextFormField(
                      initialValue: snapshotUser.data!.name ?? '',
                      decoration: InputDecoration(
                        labelText: 'Прізвище та ім\'я',
                        labelStyle: const TextStyle(
                          fontSize: 20,
                          color: AppColors.grey,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5), width: 1.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onChanged: (value) {
                        name=value;
                      },
                    ),
                  ),

                  const SizedBox(height: 30,),
                  Container(
                    child: TextFormField(
                      initialValue: snapshotUser.data!.organizations?.first['position'] ,
                      decoration: InputDecoration(
                        labelText: 'Посада',
                        labelStyle: const TextStyle(
                          fontSize: 20,
                          color: AppColors.grey,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.grey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5), width: 1.5),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onChanged: (value) {
                        position=value;
                      },
                    ),
                  ),
                  // const SizedBox(height: 30,),
                  // FutureBuilder<List<dynamic>>(
                  //     future: getOrganizationDepartments(),
                  //     builder: (context, snapshot) {
                  //
                  //       if (snapshot.connectionState == ConnectionState.waiting) {
                  //         return Center(
                  //           child: CircularProgressIndicator(
                  //             color: AppColors.black,
                  //           ),
                  //         );
                  //       }
                  //       //print('object');
                  //       // if(snapshotUser.data!.organizations?.first['department']!=null){
                  //       //   selectedOrganization = snapshotUser.data!.organizations?.first['department'];
                  //       // }
                  //       //selectedOrganization = snapshotUser.data!.organizations?.first['department'];
                  //       return DropdownButtonFormField<String>(
                  //         decoration: InputDecoration(
                  //           hintText: snapshotUser.data!.organizations?.first['department']!=null
                  //               ? snapshotUser.data!.organizations?.first['department']
                  //               :'Відділи',
                  //
                  //           hintStyle: TextStyle(
                  //               fontSize: 20,
                  //               color: AppColors.grey
                  //           ),
                  //           focusedBorder: const OutlineInputBorder(
                  //             borderSide: BorderSide(color: AppColors.grey),
                  //           ),
                  //           enabledBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5), width: 1.5),
                  //             borderRadius: BorderRadius.circular(8.0),
                  //           ),
                  //         ),
                  //
                  //         value: selectedOrganization,
                  //         onChanged: (newValue) {
                  //           setState(() {
                  //             selectedOrganization = newValue!;
                  //           });
                  //         },
                  //         items: snapshot.data!.map((department) {
                  //           return DropdownMenuItem<String>(
                  //             value: department,
                  //             child: Text(
                  //               department,
                  //               style: const TextStyle(
                  //                   fontSize: 20,
                  //                   color: AppColors.grey,
                  //                   fontWeight: FontWeight.w400
                  //               ),
                  //             ),
                  //           );
                  //         }).toList(),
                  //       );
                  //     }
                  // ),

                  const SizedBox(height: 80,),
                  Center(
                    child: CupertinoButton(
                    onPressed: () {
                      if(name != snapshotUser.data!.name){
                        if(name!=null)
                          updateUserName(name!);
                         // print('changed');
                      }
                      if(position!=snapshotUser.data!.organizations?.first['position']){
                        updatePositionInOrganization(position!);
                      }
                    },
                    color: AppColors.black,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      child: const Text('Зберегти'),
                    ),
                  ),),

                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
