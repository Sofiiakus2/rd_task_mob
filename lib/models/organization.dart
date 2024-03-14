
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

Future<void> addUserIdToVerifierList(String organizationId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> organizationDoc =
    await FirebaseFirestore.instance.collection('organization')
        .doc(organizationId)
        .get();
    List<dynamic> verifiersList =
    List.from(organizationDoc.data()?['varifier'] ?? []);

    verifiersList.add(GlobalUserState.userId);

    await FirebaseFirestore.instance.collection('organization')
        .doc(organizationId)
        .update({'varifier': verifiersList});
  } catch (e) {
    print('Error adding user to verifier list: $e');
  }
}

Future<void> deleteOrganizationFromUser(String organizationId) async{
  try {

    DocumentSnapshot<Map<String, dynamic>> userRef = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(GlobalUserState.userId)
        .get();

  if (userRef.exists && userRef.data() != null ) {
      List<dynamic> organizations = List.from(userRef.data()!['organizations']);
      print(organizations);
      organizations.removeWhere((org) => org['id'] == organizationId);
      print(organizations);
     await FirebaseFirestore.instance
          .collection('users')
          .doc(GlobalUserState.userId)
          .update({'organizations': organizations});

      GlobalOrganizationState.organizationId = '';
   }
  } catch (e) {
    print('Error removing organization from user: $e');
  }
}











