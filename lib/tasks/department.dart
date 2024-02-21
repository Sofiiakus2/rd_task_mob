import 'package:flutter/material.dart';

import 'employee.dart';

class Department {
  final String name;
  final List<Employee> employees;

  Department(this.name, this.employees);
}

List<Department> departments = [
  Department(
    'Відділ 1',
    [
      Employee('Іванов Іван', 'Менеджер'),
      Employee('Петров Петро', 'Асистент'),
      Employee('Сидорова Олена', 'Фінансист'),
    ],
  ),
  Department(
    'Відділ 2',
    [
      Employee('Коваленко Олег', 'Розробник'),
      Employee('Семенова Анна', 'Тестувальник'),
      Employee('Захарченко Марина', 'Аналітик'),
      Employee('Шевченко Ігор', 'Дизайнер'),
    ],
  ),
  Department(
    'Відділ 3',
    [
      Employee('Мороз Олексій', 'Керівник відділу'),
      Employee('Гриценко Людмила', 'Спеціаліст з реклами'),
      Employee('Богданов Денис', 'Копірайтер'),
      Employee('Ткаченко Марія', 'Менеджер зі зв\'язків з громадськістю'),
      Employee('Клименко Олександра', 'Програміст'),
    ],
  ),
];