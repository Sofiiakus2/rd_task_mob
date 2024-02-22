import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tasker/models/employee.dart';
import 'package:tasker/models/message.dart';

import '../colors.dart';
import '../models/chat.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    List<Chat> chats = Chat.chats;
    List<Employee> employees = Employee.employees;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: SizedBox(
                    width: 50,
                    child: FloatingActionButton(
                      heroTag: 'menu_button',
                      backgroundColor: AppColors.white,
                      splashColor: AppColors.grey,
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      onPressed: () {},
                      tooltip: 'Floating Action Button',
                      child: const Icon(Icons.menu,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
                      child: SizedBox(
                        width: 50,
                        child: FloatingActionButton(
                          heroTag: 'bell_button',
                          backgroundColor: AppColors.white,
                          splashColor: AppColors.grey,
                          elevation: 1.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          onPressed: () {},
                          tooltip: 'Floating Action Button',
                          child: const Icon(CupertinoIcons.bell_fill,
                            color: AppColors.black,),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
                      child: SizedBox(
                        width: 50,
                        child: FloatingActionButton(
                          heroTag: 'profile_button',
                          backgroundColor: AppColors.white,
                          splashColor: AppColors.grey,
                          elevation: 1.5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed('/profile');
                          },
                          tooltip: 'Floating Action Button',
                          child: const Icon(Icons.person,
                            color: AppColors.black,),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
            const SizedBox(height: 30,),
            Expanded(
                //color: Colors.amber,
                child: ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, index){
                  Employee employee = chats[index].employee!.where((emp) => emp.id != '1').first;
                  chats[index]
                      .messages
                      .sort((a,b) => b.createdAt.compareTo(a.createdAt),);
                  Message lastMessage = chats[index].messages.first;
                  return ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.grey.withOpacity(0.3),),
                    title: Text('${employee.name}',
                      style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text(lastMessage.text,
                    //   maxLines: 1,
                    //   style: Theme.of(context).textTheme.bodySmall,),
                    // trailing: Text('${lastMessage.createdAt.hour}:${lastMessage.createdAt.minute}',
                    //   style: Theme.of(context).textTheme.bodySmall,),
                  );
                })
            ),

          ],
        ),
      ),
    );
  }
}
