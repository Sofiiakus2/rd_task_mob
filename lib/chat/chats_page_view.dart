import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../models/chat.dart';
import '../navigationBar/top_bar_view.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: [
            TopBar(),
            const SizedBox(height: 20,),
            TextField(
              decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.search_outlined),
                fillColor: AppColors.grey.withOpacity(0.2),
                hintText: 'Пошук',
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
            const SizedBox(height:20,),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: getAllTasksWithChatsForCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Container(
                    height: MediaQuery.of(context).size.height/2,
                    alignment: Alignment.center,
                      child: Text('У вас ще немає чатів'));
                }
                final List<Map<String, dynamic>> tasks = snapshot.data ?? [];
                return Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: ( context,  index) {
                      tasks[index]['chat'].sort((dynamic a, dynamic b) {
                        DateTime dateA = (a['createdAt'] as Timestamp).toDate();
                        DateTime dateB = (b['createdAt'] as Timestamp).toDate();
                        return dateB.compareTo(dateA);
                      });
                      DateTime lastMessageTime = (tasks[index]['chat'][0]['createdAt'] as Timestamp).toDate();
                      String formattedTime = '${lastMessageTime.hour}:${lastMessageTime.minute}';
                      return ListTile(
                        onTap: (){
                          Get.toNamed('/chat', arguments: [
                            tasks[index],
                          ]);//
                        },
                          leading: CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.settings,
                              color: AppColors.grey,),
                            backgroundColor: AppColors.grey.withOpacity(0.3),),
                        title: Text('${tasks[index]['title']}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      subtitle: Text(tasks[index]['chat'][0]['text'],
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodySmall,),
                        trailing: Text(formattedTime,
                          style: Theme.of(context).textTheme.bodySmall,),

                      );
                    },
                  
                  ),
                );
              },
            ),


          ],
        ),
      ),
    );
  }
}
