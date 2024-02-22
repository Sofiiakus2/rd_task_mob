import 'dart:core';
import 'dart:core';

import 'package:tasker/models/employee.dart';
import 'package:tasker/models/message.dart';

class Chat{
  final String? id;
  final List<Employee> employee;
  final List<Message> messages;

  Chat({
    this.id,
    this.employee = const <Employee>[],
    this.messages = const <Message>[],
});

  Chat copyWith({
    String? id,
    List<Employee>? employee,
    List<Message>? messages,
}){
    return Chat(
      id: id??this.id,
      employee: employee??this.employee,
      messages: messages ?? this.messages,
    );
  }

  static List<Chat> chats = [
    Chat(
      id: '0',
      employee: Employee.employees.where((emp) => emp.id == '1'|| emp.id=='2').toList(),
      messages: Message.messages
        .where(
          (message)=>
          (message.senderId=='1'||message.recipientId=='2')&
          (message.recipientId=='1' || message.senderId=='2'),
      ).toList(),
    ),
    Chat(
      id: '1',
      employee: Employee.employees.where((emp) => emp.id == '4'|| emp.id=='3').toList(),
      messages: Message.messages
          .where(
            (message)=>
        (message.senderId=='4'||message.recipientId=='3')&
        (message.recipientId=='4' || message.senderId=='3'),
      ).toList(),
    ),
  ];
}