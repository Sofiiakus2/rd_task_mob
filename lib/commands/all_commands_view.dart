import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../colors.dart';
import '../global_storage.dart';
import '../models/organization.dart';
import '../navigationBar/top_bar_view.dart';

class AllCommands extends StatelessWidget {
  const AllCommands({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            children: [
              const TopBar(),
              Container(
                margin: const EdgeInsets.only(top: 40),
                alignment: Alignment.bottomLeft,
                child: const Text(
                  'Мої кімнати',
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: getUserOrganizations(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: AppColors.black,
                        ),
                      );
                    }
                    return snapshot.data!.isEmpty
                        ? Text('No data available')
                        : Container(
                            margin: EdgeInsets.symmetric(vertical: 30),
                            height: 3*screenSize.height/5,
                            width: screenSize.width,
                      child: SingleChildScrollView(
                        child: ListView(
                          shrinkWrap: true,
                          children: snapshot.data!.map((organization) {
                            return GestureDetector(
                              child: Container(
                                width: screenSize.width,
                                height: screenSize.height/8,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: screenSize.height/10,
                                      width: screenSize.height/10,
                                      margin: const EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:  AppColors.grey.withOpacity(0.3),
                                      ),
                                      child: const Icon(Icons.people_outline_outlined,
                                        color: AppColors.grey,
                                        size: 40,),
                                    ),
                                    Container(
                                        alignment: Alignment.topCenter,
                                        margin: const EdgeInsets.only(left: 30, top: 25),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children:
                                            [
                                              Text(organization['name'],
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.black
                                                ),
                                              ),
                                              Text(organization['usertype'],
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColors.grey
                                                ),
                                              ),
                                            ]
                                        )
                                    ),
                                    SizedBox(width: screenSize.width/20,),
                                    ElevatedButton(
                                      onPressed: () {
                                        GlobalOrganizationState.organizationId =organization['id'];
                                        print(organization['id']);
                                        Get.toNamed('/bottomNavBar');
                                        //Navigator.of(context).pushNamed('/createCommand');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.black.withOpacity(0.6),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                                        child: const Text(
                                          'Увійти',
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

                          }).toList(),
                        ),
                      ),
                    );

                  }
              ),
              ElevatedButton(
                onPressed: () {

                  Navigator.of(context).pushNamed('/createCommand');
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
                    'Створити команду',
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
      ),
    );
  }
}
