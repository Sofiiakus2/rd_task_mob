import 'package:flutter/material.dart';
import 'package:tasker/colors.dart';
import 'package:tasker/models/employee.dart';
import 'package:tasker/tasks/SelectedEmployee.dart';

import '../../models/department.dart';


class AddVAlert extends StatefulWidget {
  AddVAlert({Key? key}) : super(key: key);

  @override
  State<AddVAlert> createState() => _AddVAlertState();
}

class _AddVAlertState extends State<AddVAlert> {
  SelectedEmployee selectedEmployee = SelectedEmployee();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return AlertDialog(
      title: Center(
        child: Text(
          'Додати виконавця\n${selectedEmployee.name}',
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
        child: SingleChildScrollView(
          child: Column(
            children: Department.departments.map((department) {
              return ExpansionTile(
                title: Text(
                  department.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                children: Employee.employees.map((employee) {
                  return ListTile(
                    title: Text(
                      '${employee.name} - ${employee.position}',
                      style: TextStyle(
                        fontWeight: selectedEmployee.name == employee.name &&
                            selectedEmployee.department == department.name
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        selectedEmployee = SelectedEmployee(
                            name: employee.name, department: department.name);
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
            backgroundColor: AppColors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: const Text(
              'Додати',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
