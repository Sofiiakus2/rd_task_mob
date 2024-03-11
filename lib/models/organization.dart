
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasker/global_storage.dart';

class Organization {
  final String id;
  final String name;
  final List<String> departments;

  Organization({
    required this.id,
    required this.name,
    required this.departments,
  });

}


//get all organization departments
Future<List<dynamic>> getOrganizationDepartments() async {
  List<dynamic> departments = [];
  DocumentSnapshot? querySnapshot;

  try {
    querySnapshot = await FirebaseFirestore.instance
        .collection('organization')
        .doc(GlobalOrganizationState.organizationId)
        .get();

    if (querySnapshot.exists) {
      departments = querySnapshot['departments'];
    } else {
      print('Документ із вказаним id не знайдено.');
    }
  } catch (e) {
    print('Помилка при отриманні даних: $e');
  }
  return departments;
}

//get organization in which user participate
Future<List<Map<String, dynamic>>> getUserOrganizations() async {
  List<Map<String, dynamic>> organizations = [];
  DocumentSnapshot<Map<String, dynamic>> querySnapshot;
  try {
    querySnapshot =
    await FirebaseFirestore.instance.collection('users')
        .doc(GlobalUserState.userId)
        .get();



    if (querySnapshot.exists) {
      Map<String, dynamic>? userData = querySnapshot.data();
      if (userData != null && userData.containsKey('organizations')) {
        organizations = List<Map<String, dynamic>>.from(userData['organizations']);
      }
    }


  } catch (e) {
    print('Error getting user organizations(GLOBAL STORAGE): $e');
  }
  return organizations;
}









