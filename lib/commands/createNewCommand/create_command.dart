import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tasker/global_storage.dart';

class CreateOrganization extends StatefulWidget {
  final String name;
  final List<String> departments;

  const CreateOrganization({
    required this.name,
    required this.departments,
    Key? key
  }): super(key: key);

  @override
  State<CreateOrganization> createState() => _CreateOrganizationState();

  Future<void> addOrUpdateOrganizationToUser() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('organization')
          .where('name', isEqualTo: name)
          .where('departments', isEqualTo: departments)
          .get();

      List<Map<String, dynamic>> organizations = [];

      querySnapshot.docs.forEach((doc) {
        organizations.add({
          'id': doc.id,
          'name': name,
          'usertype': 'admin',
        });
      });

      await FirebaseFirestore.instance.collection('users').doc(GlobalUserState.userId).set({
        'organizations': FieldValue.arrayUnion(organizations),
      }, SetOptions(merge: true));

    } catch (e) {
      print('Creating new organization Error: $e');
    }
  }

  Future<void> writeOrganizationData()async{
    try{
      await FirebaseFirestore.instance.collection('organization').add({
        'name': name,
        'departments':departments,
      });
    }catch(e){
      print(e);
    }
  }
}



class _CreateOrganizationState extends State<CreateOrganization> {

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
