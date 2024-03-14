
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasker/global_storage.dart';


class User {
  final String id;
  final String name;
  final List<Map<String, dynamic>>? organizations;
  final String password;

  User({
    required this.id,
    required this.name,
    required this.organizations,
    required this.password,
});

}

Future<User?> getUserById(String userId) async{
  User? user;
  try{
    DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (userSnapshot.exists) {
      Map<String, dynamic>? userData = userSnapshot.data();
      if (userData != null) {
        List<dynamic> organizationData = userData['organizations'];

        for (var org in organizationData){
          if(org['id']==GlobalOrganizationState.organizationId)
          {
            user = User(
              id: GlobalUserState.userId.toString(),
              name: userData['name'],
              organizations: [
                {
                  'name': org['name'],
                  'position': org['position'],
                  'userType': org['userType'],
                  'department': org['department'],
                }
              ],
              password: userData['password'] ?? '',
            );
          }
        }

      }
    }
  }catch(e){
    print(e);
  }
  return user;
}

Future<User?> getCurrentUser() async {
  User? currentUser;
  try {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(GlobalUserState.userId)
        .get();

    print(GlobalUserState.userId);
    print(userSnapshot.data());
    if (userSnapshot.exists) {
      Map<String, dynamic>? userData = userSnapshot.data();
      if (userData != null) {
        List<dynamic> organizationData = userData['organizations'];
        //print(GlobalOrganizationState.organizationId);
        for (var org in organizationData){
          if(org['id']==GlobalOrganizationState.organizationId)
            {
              currentUser = User(
                id: GlobalUserState.userId.toString(),
                name: userData['name'],
                organizations: [
                  {
                    'name': org['name'],
                    'position': org['position'],
                    'userType': org['userType'],
                    'department': org['department'],
                  }
                ],
                password: userData['password'] ?? '',
              );
            }
        }

      }
    }
  } catch (e) {
    print('getCurrentUser TROUBLE $e');
  }
  return currentUser;
}

Future<List<User>> getAllUsers() async {
  List<User> users = [];

  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
    await FirebaseFirestore.instance.collection('users').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in querySnapshot.docs) {
      List<Map<String, dynamic>>? userOrganizations;
      if (doc.data().containsKey('organizations')) {
        userOrganizations = List<Map<String, dynamic>>.from(doc.data()['organizations']);
      } else {
        userOrganizations = null;
      }

      users.add(User(
        id: doc.id,
        name: doc['name'],
        organizations: userOrganizations,
        password: doc['password'],
      ));
    }
  } catch (e) {
    print('Error getting usersGETALLUSERS: $e');
  }

  return users;
}


//all users in current organization to find future performer for task
Future<List<User>> getUsersInOrganization(String department) async {
  List<User> users = await getAllUsers();
  List<User> usersInOurOrganization = [];
  for (User user in users) {
    if (user.organizations != null) {
      for (Map<String, dynamic> organization in user.organizations!) {
        if (organization['id'] == GlobalOrganizationState.organizationId) {
          if(organization['department']==department)
            usersInOurOrganization.add(user);

        }
      }
    }
  }

  return usersInOurOrganization;
}

Future<void> updateUserName(String newName) async {
  try {
    DocumentReference userDocRef = FirebaseFirestore.instance
        .collection('users')
        .doc(GlobalUserState.userId);

    await userDocRef.set(
      {'name': newName},
      SetOptions(merge: true),
    );
    print('Поле "ім\'я" успішно оновлено або додано');
  } catch (e) {
    print('Помилка під час оновлення поля "ім\'я": $e');
  }
}

Future<void> updatePositionInOrganization(String newPosition) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(GlobalUserState.userId)
        .get();

    if (userDoc.exists && userDoc.data() != null && userDoc.data()!.containsKey('organizations')) {
      List<dynamic> organizations = userDoc.data()!['organizations'];

      for (var organization in organizations) {
        if (organization['id'] == GlobalOrganizationState.organizationId) {
          print('Знайдено організацію з id ${GlobalOrganizationState.organizationId}');
          organization['position'] = newPosition;

          await FirebaseFirestore.instance
              .collection('users')
              .doc(GlobalUserState.userId)
              .set({'organizations': organizations}, SetOptions(merge: true));

          break;
        }
      }
    }
  } catch (e) {
    print('Помилка під час оновлення поля "position": $e');
  }
}

Future<void> updateDepartmentInOrganization(String id, String newDepartment) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get();


    if (userDoc.exists && userDoc.data() != null && userDoc.data()!.containsKey('organizations')) {
      List<dynamic> organizations = userDoc.data()!['organizations'];
      for (var organization in organizations) {
        if (organization['id'] == GlobalOrganizationState.organizationId) {
          organization['department'] = newDepartment;

          await FirebaseFirestore.instance
              .collection('users')
              .doc(id)
              .set({'organizations': organizations}, SetOptions(merge: true));

          break;
        }
      }
    }
  } catch (e) {
    print('Помилка під час оновлення поля "position": $e');
  }
}






