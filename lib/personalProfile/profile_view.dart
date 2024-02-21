import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasker/colors.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> organizations = ['Організація 1', 'Організація 2', 'Організація 3'];
  String selectedOrganization = 'Організація 1';

  // List<String> departments = ['Відділ 1', 'Відділ 2', 'Відділ 3'];
  // String selectedDepartment = 'Відділ 1';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.navigate_before, color: AppColors.grey, size:30,),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.white,
        title: const Text(
          'Профіль',
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.white,
        margin: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){

                  },
                  child: Container(
                    width: screenSize.width/5,
                    height: screenSize.width/5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.grey.withOpacity(0.3),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.perm_identity,
                        color: AppColors.grey,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Телефон',
                      labelStyle: const TextStyle(
                          fontSize: 20,
                          color: AppColors.grey
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5), width: 1.5),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50,),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Прізвище та ім\'я',
                  labelStyle: const TextStyle(
                      fontSize: 20,
                      color: AppColors.grey
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5), width: 1.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            Container(
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Посада',
                  labelStyle: const TextStyle(
                      fontSize: 20,
                      color: AppColors.grey
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5), width: 1.5),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30,),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5), width: 1.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              value: selectedOrganization,
              onChanged: (newValue) {
                setState(() {
                  selectedOrganization = newValue!;
                });
              },
              items: organizations.map((String organization) {
                return DropdownMenuItem<String>(
                  value: organization,
                  child: Text(organization,
                    style: const TextStyle(
                        fontSize: 20,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w400
                    ),
                  ),

                );
              }).toList(),
            ),
            // const SizedBox(height: 30,),
            // DropdownButtonFormField<String>(
            //   decoration: InputDecoration(
            //     focusedBorder: const OutlineInputBorder(
            //       borderSide: BorderSide(color: AppColors.grey),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5), width: 1.5),
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //   ),
            //   value: selectedDepartment,
            //   onChanged: (newValue) {
            //     setState(() {
            //       selectedDepartment = newValue!;
            //     });
            //   },
            //   items: departments.map((String department) {
            //     return DropdownMenuItem<String>(
            //       value: department,
            //       child: Text(department,
            //         style: const TextStyle(
            //             fontSize: 20,
            //             color: AppColors.grey,
            //             fontWeight: FontWeight.w400
            //         ),
            //       ),
            //
            //     );
            //   }).toList(),
            // ),
            const SizedBox(height: 80,),
            Center(
              child: CupertinoButton(
              onPressed: () {},
              color: AppColors.black,
              child: Container(
                margin: const EdgeInsets.all(10),
                child: const Text('Зберегти'),
              ),
            ),),

          ],
        ),
      ),
    );
  }
}
