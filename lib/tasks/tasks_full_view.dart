import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasker/colors.dart';
import 'dart:core';
import 'package:flutter_svg/flutter_svg.dart';
import '../global_storage.dart';
import '../navigationBar/top_bar_view.dart';
import 'package:intl/intl.dart';

class FullTasks extends StatelessWidget {
  FullTasks({super.key});
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: Stack(
            children: [
              Container(
                margin: const EdgeInsets.all(30),
                child: Column(
                  children: [
                    const TopBar(),
                    Container(
                      margin: const EdgeInsets.only(top: 60),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Перелік\nзадач',
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 3.5 * screenSize.height / 6,
                  width: screenSize.width,
                  decoration: const BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: FutureBuilder<List<DocumentSnapshot<Map<String, dynamic>>>>(
                    future: getTasks(),
                    builder: (context,snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: AppColors.black,
                          ),
                        );
                      }
                      return snapshot.data!.isEmpty
                          ? Container(
                          height: 3 * screenSize.height / 5,
                          width: screenSize.width,
                          decoration: const BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              topRight: Radius.circular(40.0),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'У вас немає завдань',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ))
                          : Container(
                        height: 3 * screenSize.height / 5,
                        width: screenSize.width,
                        decoration: const BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
                          child: ListView(
                            shrinkWrap: true,
                            children: snapshot.data!.map((task) {
                              Widget trailingWidget;
                              final progressPercentage = (task.data()?['progress']).toStringAsFixed(0);
                              if (progressPercentage == '100') {
                                trailingWidget = const Icon(Icons.check, color: AppColors.black);
                              } else {
                                trailingWidget = Text(
                                  '$progressPercentage%',
                                  style: const TextStyle(
                                    color: AppColors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed('/editTasks', arguments: [
                                    task.data(),
                                    task.id
                                  ]);
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 20),
                                      leading: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: AppColors.grey.withOpacity(0.3),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: const Icon(Icons.settings, color: AppColors.grey),
                                      ),
                                      title: Text(
                                        task.data()?['title'],
                                        style: const TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          FutureBuilder<String?>(
                                              future: getUserName(),
                                              builder: (context,snapshot){
                                                return Text(snapshot.data??'');
                                              }),

                                          Text(DateFormat('dd-MM-yy').format(task.data()?['date'].toDate())),

                                        ],
                                      ),
                                      trailing: trailingWidget,
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: AppColors.grey.withOpacity(0.3),
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                      );
                    },
                  )
                ),
              ),
              Positioned(
                bottom: 3.5 * screenSize.height / 6.5,
                right: 40,
                child: Container(
                  // color: Colors.lightGreen,
                  child: SvgPicture.asset(
                    'assets/2.svg',
                    width: screenSize.width/2,
                    // height: 100,
                  ),
                ),
              ),
            ],
          ),

      );

  }
}
