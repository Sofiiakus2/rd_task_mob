
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
