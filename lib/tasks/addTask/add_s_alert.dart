import 'package:flutter/material.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/models/employee.dart';
import 'package:tasker/tasks/SelectedEmployee.dart';

import '../../models/department.dart';




class AddSAlert extends StatefulWidget {
  AddSAlert({Key? key}) : super(key: key);

  @override
  State<AddSAlert> createState() => _AddVAlertState();
}

class _AddVAlertState extends State<AddSAlert> {
  List<SelectedEmployee> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      title: Center(
        child: Text(
          'Додати спостерігачів',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      content: Container(
        width: screenSize.width - 20,
        height: screenSize.height / 2,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: Department.departments.map((department) {
              return ExpansionTile(
                title:selectedItems.any((item)=>item.department==department.name)
                ?Wrap(

                  children: selectedItems.map((e) {
                    if (e.department == department.name) {
                      return Chip(
                        backgroundColor: AppColors.grey.withOpacity(0.3),
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.darkGrey
                        ),
                        label: Text(e.name),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: AppColors.grey.withOpacity(0.3),
                            width: 0
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(); // Порожня коробка, яка не буде відображатись
                    }
                  }).toList(),
                )
                :Text(
                  department.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                children: Employee.employees.map((employee) {
                  return CheckboxListTile(
                    title: Text(
                      '${employee.name} - ${employee.position}',
                      style: TextStyle(
                        fontWeight: selectedItems.contains(employee.name) &&
                            selectedItems.contains(department.name)
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    value: selectedItems.any((item) => item.name == employee.name && item.department == department.name),

                    onChanged: (bool? value) {
                      setState(() {
                        if (value != null && value) {
                          selectedItems.add(SelectedEmployee(name: employee.name, department: department.name));
                        } else {
                          selectedItems.removeWhere((item) =>
                          item.name == employee.name && item.department == department.name);
                        }
                      });
                    },

                  );
                }).toList(),
              );
            }).toList(),
          ),
        ),
      ),

      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: const Text(
              'Додати',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
