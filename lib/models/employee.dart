import 'package:flutter/material.dart';

import 'department.dart';

class Employee {
  final String id;
  final String name;
  final String position;
  final Department department;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.department,
}
      );

  static List<Employee> employees = [

    Employee(
        id: '0',
        name: 'Іванов Іван',
        position: 'Менеджер',
        department: Department.departments[0],
    ),

    Employee(
        id: '1',
        name: 'Петров Петро',
        position: 'Асистент',
      department: Department.departments[1],),

    Employee(
        id: '2',
        name: 'Сидорова Олена',
        position: 'Фінансист',
      department: Department.departments[0],),

    Employee(
        id: '3',
        name: 'Коваленко Олег',
        position: 'Розробник',
      department: Department.departments[2],),

    Employee(
        id: '4',
        name: 'Семенова Анна',
        position: 'Тестувальник',
      department: Department.departments[0],),

    Employee(
        id: '5',
        name: 'Захарченко Марина',
        position: 'Аналітик',
      department: Department.departments[1],),

    Employee(
        id: '6',
        name: 'Шевченко Ігор',
        position: 'Дизайнер',
      department: Department.departments[1],),

    Employee(
        id: '7',
        name: 'Мороз Олексій',
        position: 'Керівник відділу',
      department: Department.departments[2],),

    Employee(
        id: '8',
        name: 'Гриценко Людмила',
        position: 'Спеціаліст з реклами',
      department: Department.departments[2],),

    Employee(
        id: '9',
        name: 'Богданов Денис',
        position: 'Копірайтер',
      department: Department.departments[1],),

    Employee(
        id: '10',
        name: 'Ткаченко Марія',
        position: 'Менеджер зі зв\'язків з громадськістю',
      department: Department.departments[1],),

    Employee(
        id: '11',
        name: 'Клименко Олександра',
        position: 'Програміст',
      department: Department.departments[2],),


  ];
}

