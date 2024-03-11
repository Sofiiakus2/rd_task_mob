
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_string/random_string.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/global_storage.dart';

import '../models/chat.dart';

class CurrentChat extends StatefulWidget {
  const CurrentChat({Key? key}):super(key: key);

  @override
  State<CurrentChat> createState() => _CurrentChatState();
}

class _CurrentChatState extends State<CurrentChat> {
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();
  late Map<String,dynamic> task;
  late List<dynamic> chat = [];
  late String text;

  @override
  void initState() {
    task = Get.arguments[0];
    if (task.containsKey('chat')) {
      chat = task['chat'];
    }
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    chat = task['chat'];
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white.withAlpha(1000),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: screenSize.height / 6,
                  margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: AppColors.darkGrey,
                            ),
                          ),
                          SizedBox(width: screenSize.width/20,),
                          Container(
                            width: screenSize.width / 7,
                            height: screenSize.width / 7,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.grey.withOpacity(0.3),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.perm_identity,
                                color: AppColors.grey,
                                size: 40,
                              ),
                            ),
                          ),
                          SizedBox(width: screenSize.width/15,),

                      Text(
                        task['title'],
                        style: const TextStyle(
                          color: AppColors.darkGrey,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 4* screenSize.height / 5,
                width: screenSize.width,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Expanded(
                          child: (chat.isEmpty)
                              ? Center(child: Text('У вас поки немає повідомлень'))
                              : ListView.builder(
                            controller: scrollController,
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: chat.length,
                              itemBuilder: (context, index){

                                //Message message = chat.messages[index];
                                return Align(
                                    alignment: (chat[index]['senderId']==GlobalUserState.userId)//(message.senderId=='1')
                                        ?Alignment.centerRight
                                        :Alignment.centerLeft,
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: screenSize.width*0.66,
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                          color: (chat[index]['senderId']==GlobalUserState.userId)
                                              ?AppColors.grey.withOpacity(0.3)
                                              :AppColors.grey
                                      ),
                                      margin: const EdgeInsets.symmetric(vertical: 15.0),
                                      child: Text(
                                        chat[index]['text'],
                                        style: Theme.of(context).textTheme.bodyMedium,
                                      ),
                                    ));
                              }),
                      ),
                      TextFormField(
                        controller: textEditingController,
                        onChanged: (value){
                          setState(() {
                            text = value;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.grey.withOpacity(0.2),
                          hintText: 'Коментар',
                          hintStyle: const TextStyle(
                            color: AppColors.darkGrey
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(20),
                          suffixIcon: IconButton(
                            onPressed: (){
                              print(task['id']);
                              String messageId = randomAlphaNumeric(10);
                              DateTime createdAt = DateTime.now();
                               FirebaseFirestore.instance.collection('tasks')
                                 .doc(task['id'])
                                .update({
                                 'chat': FieldValue.arrayUnion([
                                   {
                                     'text': text,
                                     'messageId':messageId,
                                     'senderId':GlobalUserState.userId,
                                     'createdAt':createdAt,
                                   }
                                 ])
                               }).then((value) {
                                 print('eeeee');
                               }).catchError((error){
                                 print(error);
                               });
                              setState(() {
                                task['chat'].insert(0, {
                                  'text': text,
                                  'messageId': messageId,
                                  'senderId': GlobalUserState.userId,
                                  'createdAt': createdAt,
                                });
                              });
                              scrollController.animateTo(
                                scrollController.position.minScrollExtent,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,);
                              textEditingController.clear();
                            },
                            icon: const Icon(Icons.send,
                            color: AppColors.darkGrey,),
                          ),
                          prefixIcon: const IconButton(
                            onPressed: _pickFile,
                            //     (){
                            //   showModalBottomSheet(
                            //       context: context,
                            //       builder: (builder)=>bottomsheet());
                            // },
                            icon: Icon(Icons.attach_file,
                              color: AppColors.darkGrey,),
                          )
                        ),

                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
  // Widget bottomsheet(){
  //   return Container(
  //     height: 150,
  //     width: MediaQuery.of(context).size.width,
  //     child: Container(
  //       margin: EdgeInsets.only(top: 40),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           Column(
  //             //mainAxisAlignment: MainAxisAlignment.center,
  //
  //             children: [
  //               CircleAvatar(
  //                 radius: 30,
  //                 backgroundColor: AppColors.black,
  //                 child: IconButton(
  //                   onPressed: _pickFile,
  //                   icon: Icon(
  //                     Icons.file_open_sharp,
  //                     color: AppColors.white,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 5),
  //               Text(
  //                 'Файл',
  //                 style: TextStyle(
  //                   color: AppColors.black,
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Column(
  //             children: [
  //               CircleAvatar(
  //                 radius: 30,
  //                 backgroundColor: AppColors.black,
  //                 child: IconButton(
  //                   onPressed: (){},
  //                   icon: Icon(
  //                     Icons.photo_camera,
  //                     color: AppColors.white,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 5),
  //               Text(
  //                 'Камера',
  //                 style: TextStyle(
  //                   color: AppColors.black,
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Column(
  //             children: [
  //               CircleAvatar(
  //                 radius: 30,
  //                 backgroundColor: AppColors.black,
  //                 child: IconButton(
  //                   onPressed: () {},
  //                   icon: Icon(
  //                     Icons.image,
  //                     color: AppColors.white,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 5),
  //               Text(
  //                 'Зображення',
  //                 style: TextStyle(
  //                   color: AppColors.black,
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Column(
  //             children: [
  //               CircleAvatar(
  //                 radius: 30,
  //                 backgroundColor: AppColors.black,
  //                 child: IconButton(
  //                   onPressed: () {},
  //                   icon: Icon(
  //                     Icons.person,
  //                     color: AppColors.white,
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 5),
  //               Text(
  //                 'Контакт',
  //                 style: TextStyle(
  //                   color: AppColors.black,
  //                   fontSize: 12,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     )
  //
  //   );
  // }

}

void _pickFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    PlatformFile file = result.files.first;
  } else {
  }
}




