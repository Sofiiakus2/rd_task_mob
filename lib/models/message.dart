class Message{
  final String senderId;
  final String recipientId;
  final String text;
  final DateTime createdAt;

  const Message({
    required this.senderId,
    required this.recipientId,
    required this.text,
    required this.createdAt,
  });

  static List<Message> messages = [
     Message(
         senderId: '1',
         recipientId: '2',
         text: 'На небі хмари, як той мох, що примерз до землі у лісовій тишині — сірий, ледом укритий. Сірі хмари станули над заходом та й закаменіли.',
         createdAt: DateTime.now(),
     ),
    Message(
      senderId: '2',
      recipientId: '1',
      text: 'Там схований шелест листків придорожніх, що шептали, аби вівці мої їх не переступили, аби в шкоду не забігали. Там закляті слова коханки. Що слово промовляла, то кожде співало.',
      createdAt: DateTime(2024,2,1,10,10,10),
    ),
    Message(
      senderId: '1',
      recipientId: '2',
      text: 'Краями квіт мій застигає. Мороз в душу лізе, у середній листочок найменьший, що ще жовтавий. — Вполудне приходиш, сонце. Збавляєш мене від смерти. Не приходи вже! Най зів’ян',
      createdAt: DateTime(2024,1,1,10,10,10),
    ),
    Message(
      senderId: '3',
      recipientId: '4',
      text: 'Під горою коло ліса стоїть хатина. Повзає по землі, як перевалений хрущ. Віконця якурат такі, як хрущеві пасують. Маленька сіточка шибок у рямках.',
      createdAt: DateTime(2024,2,1,10,15,10),
    ),
  ];
}