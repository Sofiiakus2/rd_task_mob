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
      employee: Employee.employees.where((emp) => emp.id == '1'|| emp.id=='2').toList()

    ),
  ];
}