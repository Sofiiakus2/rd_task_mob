import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tasker/models/employee.dart';
import 'package:tasker/models/message.dart';
import 'package:get/get.dart';

import '../colors.dart';
import '../models/chat.dart';
import '../top_bar_view.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Chat> chats = Chat.chats;

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
            Expanded(
                child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index){
                  Employee employee = chats[index].employee.where((emp) => emp.id != '1').first;
                  chats[index]
                      .messages
                      .sort((a,b) => b.createdAt.compareTo(a.createdAt),);

                  Message lastMessage = chats[index].messages.first;
                  return ListTile(
                    onTap: (){
                      Get.toNamed('/chat', arguments: [
                        employee,
                        chats[index],
                      ]);
                    },
                    leading: CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.settings,
                        color: AppColors.grey,),
                        backgroundColor: AppColors.grey.withOpacity(0.3),),
                    title: Text('${chats[index].task.title}',
                      style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(lastMessage.text,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodySmall,),
                    trailing: Text('${lastMessage.createdAt.hour}:${lastMessage.createdAt.minute}',
                      style: Theme.of(context).textTheme.bodySmall,),
                  );
                })
            ),

          ],
        ),
      ),
    );
  }
}
