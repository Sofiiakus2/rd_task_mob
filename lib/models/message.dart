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
         text: 'Привіт',
         createdAt: DateTime.now(),
     ),
    Message(
      senderId: '4',
      recipientId: '3',
      text: 'Привіт',
      createdAt: DateTime.now(),
    ),
  ];
}