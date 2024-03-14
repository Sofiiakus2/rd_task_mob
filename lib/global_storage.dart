import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';


class GlobalUserState {
  static String? userId;
  static String? userType;
  static String? messageId;
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

Future<String?> getUserType(String taskId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
        .instance
        .collection('tasks')
        .doc(taskId)
        .get();

    if(GlobalUserState.userId == userDoc.data()!['supervisorId']){
      return 'supervisor';
    }
    else{
      return 'performer';
    }

  } catch (e) {
    print('Error getting user type: $e');
  }

  return null;
}


Future<void> deleteMiniTaskInGlobalTask(String taskId, String miniTaskName) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> taskDoc = await FirebaseFirestore
        .instance
        .collection('tasks')
        .doc(taskId)
        .get();

    if (taskDoc.exists && taskDoc.data() != null) {
      List<dynamic> miniTasks = List.from(taskDoc.data()!['miniTasks']);

      // Перевіряємо всі міні-завдання у списку
      for (int i = 0; i < miniTasks.length; i++) {
        Map<String, dynamic> miniTask = miniTasks[i];
        if (miniTask['name'] == miniTaskName) {
          // Знайдено співпадіння за ім'ям, видаляємо елемент зі списку
          miniTasks.removeAt(i);

          // Оновлюємо документ у Firestore з оновленим списком miniTasks
          await FirebaseFirestore.instance
              .collection('tasks')
              .doc(taskId)
              .update({'miniTasks': miniTasks});

          print('Mini task deleted successfully');
          return; // Завершуємо функцію після видалення
        }
      }

      print('Mini task not found in task miniTasks');
    } else {
      print('Task document not found');
    }
  } catch (e) {
    print('Error deleting mini task: $e');
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
