import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GlobalUserState {
  static String? userId;

}


//get user name
Future<String?> getUserName() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userName');
}

//get task performer name
Future<String?> getPerformerName(String performerId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance.collection('users').doc(performerId).get();
    if (userDoc.exists && userDoc.data() != null && userDoc.data()!.containsKey('name')) {
      return userDoc.data()!['name'];
    } else {
      return null;
    }
  } catch (e) {
    print('Error getting performer name: $e');
    return null;
  }
}

//get all tasks that User should do
Future<List<DocumentSnapshot<Map<String, dynamic>>>> getTasks() async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('tasks').get();
    return querySnapshot.docs
        .where((doc) => doc.data()['roomId'] == GlobalOrganizationState.organizationId)
        .where((doc) => doc.data()['performerId'] == GlobalUserState.userId)
        .toList();
  } catch (e) {
    print('Error getting tasks: $e');
    return [];
  }
}

//get all tasks that User is watching
Future<List<DocumentSnapshot<Map<String, dynamic>>>> getMonitoringTasks() async {
  try {
    List<DocumentSnapshot<Map<String, dynamic>>> tasks = [];
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('tasks').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
       if(doc['roomId'] == GlobalOrganizationState.organizationId){
           if(doc['supervisorId']!=null && doc['supervisorId'] == GlobalUserState.userId){
             tasks.add(doc);
           }else{
             if (doc['assigneesIds'] != null){
               List<dynamic> assigneesIds = doc['assigneesIds'];
               if (assigneesIds.contains(GlobalUserState.userId)) {
                 //print(doc);
                 tasks.add(doc);
               }
             }
           }
       }


    }

    return tasks;
  } catch (e) {
    print('Error getting tasks: $e');
    return [];
  }
}







class GlobalOrganizationState{
  static String? organizationId;
}
