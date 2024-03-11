import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/global_storage.dart';
import 'dart:core';
import 'package:intl/intl.dart';
import '../../navigationBar/top_bar_view.dart';

class MonitoringTasks extends StatelessWidget {
  MonitoringTasks({super.key});
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
                  margin: const EdgeInsets.only(top: 80),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Трекер\nзадач',
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
                future: getMonitoringTasks(),
                builder: (context, snapshot){
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
                          children: [

                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                Widget trailingWidget;
                                final progressPercentage = (snapshot.data?[index]['progress']).toStringAsFixed(0);

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
                                  onTap: (){
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => EditTasksL(task: tasks[index]),
                                    //   ),
                                    // );
                                  },
                                  child: Column(
                                      children:[
                                        ListTile(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 20),
                                          leading: Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                              color: AppColors.grey.withOpacity(0.3),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: const Icon(Icons.settings,
                                              color: AppColors.grey,),
                                          ),
                                          title: Text(snapshot.data?[index]['title'],
                                            style: const TextStyle(
                                                color: AppColors.black,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          subtitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              FutureBuilder<String?>(
                                                  future: getPerformerName(snapshot.data?[index]['performerId']),
                                                  builder: (context,snapshot){
                                                    return Text(snapshot.data??'');
                                                  }),
                                              Text(DateFormat('dd-MM-yy').format(snapshot.data?[index]['date'].toDate())),

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
                                      ]
                                  ),
                                );

                              },

                            ),
                          ],
                        ),
                      )
                  );
    },
    ),

            ),
          ),
          Positioned(
            bottom: 3.5 * screenSize.height / 6.5,
            right: 40,
            child: Container(
              child: SvgPicture.asset(
                'assets/1.svg',
                width: screenSize.width/2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
