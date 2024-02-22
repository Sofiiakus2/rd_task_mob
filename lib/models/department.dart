
class Department {
  final String name;

  Department(  {
    required this.name,
  });

  static List<Department> departments = [
    Department(
      name: 'Відділ 1',
    ),
    Department(
      name: 'Відділ 2',
    ),
    Department(
      name: 'Відділ 3',
    ),
  ];
}

