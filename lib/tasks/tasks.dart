class Task {
  final String title;
  final String performer;
  final String date;
  final double progress;
  final String result;
  final List<String> miniTasks;
  final String assigner;
  final List<String>? assignees;

  Task({
    required this.title,
    required this.performer,
    required this.date,
    required this.progress,
    required this.result,
    required this.miniTasks,
    required this.assigner,
    this.assignees,
  });

  static List<Task> tasks = [
    Task(
      title: 'Розробити сторінки',
      performer: 'Софія',
      date: '2024-02-10',
      progress: 0.3,
      result: 'Робоча програма зі всім робочим функціоналом',
      miniTasks: [
        'Сторінки вхід/реєстрація',
        'Сторінка редагувати задачу',
        'Сторінка чату',
        'Сторінки вхід/реєстрація',
        'Сторінка редагувати задачу',
        'Сторінка чату',

      ],
      assigner: 'Роман',

    ),
    Task(
      title: 'Ще якесь завдання',
      performer: 'Jane Smith',
      date: '2024-02-16',
      progress: 1,
      result: 'Виконане завдання',
      miniTasks: [
        'завдання'
      ], assigner: 'Олег',
    ),
    Task(
      title: 'Ще якесь завдання 3',
      performer: 'Jane Smith',
      date: '2024-02-16',
      progress: 1,
      result: 'Виконане завдання',
      miniTasks: [
        'завдання'
      ], assigner: 'Олег',
    ),

  ];
}

