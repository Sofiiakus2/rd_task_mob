
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasker/global_storage.dart';

import '../models/users.dart';

Future<List<User>> getAllUnverifiedUsers() async {
  List<User> users = [];
  List<String> verifiers = [];
  try {
    DocumentSnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('organization')
        .doc(GlobalOrganizationState.organizationId)
        .get();

    List<dynamic>? varifiersList = querySnapshot.data()?['varifier'];
    if (varifiersList != null) {
      verifiers.addAll(varifiersList.map((e) => e.toString()));
    }

    QuerySnapshot<Map<String, dynamic>> usersSnapshot =
    await FirebaseFirestore.instance.collection('users').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> userDoc in usersSnapshot.docs) {
      String userId = userDoc.id;
      List<Map<String, dynamic>>? userOrganizations;
      if (userDoc.data().containsKey('organizations')) {
        userOrganizations = List<Map<String, dynamic>>.from(userDoc.data()['organizations']);
      } else {
        userOrganizations = null;
      }
      if (verifiers.contains(userId)) {
        users.add(User(
          id: userDoc.id,
          name: userDoc['name'],
          organizations: userOrganizations,
          password: userDoc['password'],
        ));
      }
    }

  } catch (e) {
    print('Error getting usersGETALLUSERS: $e');
  }

  return users;
}

Future<List<Map<String, dynamic>>> getUsersWithoutDepartments() async {
  List<Map<String, dynamic>> users = [];
  try {
    QuerySnapshot usersSnapshot = await FirebaseFirestore.instance.collection('users').get();
    for (QueryDocumentSnapshot userDoc in usersSnapshot.docs) {
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      String userId = userDoc.id;

      if (userData.containsKey('organizations')) {
        List<dynamic> userOrganizations = userData['organizations'];
        for (int j = 0; j < userOrganizations.length; j++) {
          if (userOrganizations[j]['id'] == GlobalOrganizationState.organizationId) {
            if (userOrganizations[j]['department'] == null) {
              userData['id'] = userId;
              users.add(userData);
            }
          }
        }
      }
    }
  } catch (e) {
    print("Error: $e");
  }
  return users;
}



Future<void> deleteUserFromoCurrentCommand(String userId) async{
  try{
    DocumentSnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('organization')
        .doc(GlobalOrganizationState.organizationId)
        .get();

    List<String> verifierList = List<String>.from(querySnapshot.data()!['varifier']);

    String userIdToRemove = userId;
    verifierList.remove(userIdToRemove);

    await FirebaseFirestore.instance
        .collection('organization')
        .doc(GlobalOrganizationState.organizationId)
        .update({'varifier': FieldValue.arrayRemove([userIdToRemove])});
  }catch (e) {
    print('Creating new organization Error: $e');
  }
}

Future<void> addUserToCurrentCommand(String userId, bool userType) async{
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('organization')
          .doc(GlobalOrganizationState.organizationId)
          .get();

      if (querySnapshot.exists && querySnapshot.data() != null && querySnapshot.data()!['varifier'] is List) {
        Map<String, dynamic> organizationData = querySnapshot.data()!;
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'organizations': FieldValue.arrayUnion([
            {
              'id': GlobalOrganizationState.organizationId,
              'name': organizationData['name'],
              'usertype': userType ? 'subAdmin' : 'user',
            }
          ]),
        }, SetOptions(merge: true));


        List<String> verifierList = List<String>.from(querySnapshot.data()!['varifier']);

        String userIdToRemove = userId;
        verifierList.remove(userIdToRemove);

        await FirebaseFirestore.instance
            .collection('organization')
            .doc(GlobalOrganizationState.organizationId)
            .update({'varifier': FieldValue.arrayRemove([userIdToRemove])});
      }



    } catch (e) {
      print('Creating new organization Error: $e');
    }

}