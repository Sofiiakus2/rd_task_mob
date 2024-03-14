
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasker/global_storage.dart';

Future<List<Map<String, dynamic>>> getAllTasksWithChatsForCurrentUser() async {
  List<Map<String, dynamic>> chatList = [];
  try {
    QuerySnapshot<Map<String, dynamic>> organizationSnapshot = await FirebaseFirestore.instance
        .collection('tasks')
        .where('roomId', isEqualTo: GlobalOrganizationState.organizationId)
        .get();

    if (organizationSnapshot.docs.any((doc) => doc.data()['performerId'] == GlobalUserState.userId)
        || organizationSnapshot.docs.any((doc) => doc.data()['supervisorId'] == GlobalUserState.userId)
        || organizationSnapshot.docs.any((doc) => (doc.data()['assigneesIds'] as List).contains(GlobalUserState.userId))) {
      if (organizationSnapshot.docs.any((doc) => doc.data().containsKey('chat'))) {
        chatList = organizationSnapshot.docs
            .where((doc) => doc.data().containsKey('chat'))
            .map((doc) => {'id': doc.id, ...doc.data()})
            .toList();
      }
    }


    return chatList;
  } catch (e) {
    print('Error getting all chats: $e');
    return [];
  }
}

Future<String> getSenderName(String userId) async {
  DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('users').doc(userId).get();
  if (userSnapshot.exists) {
    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    return userData['name'];
  } else {
    return '';
  }
}

Future<void> deleteMessage(String taskId, String messageId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> taskDoc =
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).get();

    if (taskDoc.exists && taskDoc.data() != null) {
      List<dynamic> chat = List.from(taskDoc.data()!['chat']);

      for (int i = 0; i < chat.length; i++) {
        Map<String, dynamic> chats = Map.from(chat[i]);
        if (chats['messageId'] == messageId) {
          chat.removeAt(i);
          await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
            'chat': chat,
          });

          return;
        }
      }

    } else {
      print('Task document not found');
    }
  } catch (e) {
    print('Error deleting message: $e');
  }
}

Future<void> editMessage(String taskId,  String newText) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> taskDoc =
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).get();

    if (taskDoc.exists && taskDoc.data() != null) {
      List<dynamic> chat = List.from(taskDoc.data()!['chat']);
      for (int i = 0; i < chat.length; i++) {
        Map<String, dynamic> chatMessage = Map.from(chat[i]);
        if (chatMessage['messageId'] == GlobalUserState.messageId) {
            chatMessage['text'] = newText;
            chat[i] = chatMessage;
            await FirebaseFirestore.instance.collection('tasks').doc(taskId).update({
              'chat': chat,
            });

            print('Message edited successfully');
            return;

        }
      }

      print('Message not found in chat');
    } else {
      print('Task document not found');
    }
  } catch (e) {
    print('Error editing message: $e');
  }
}
