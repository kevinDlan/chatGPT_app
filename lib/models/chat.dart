import 'package:flutter/material.dart';

@immutable
class Chat {
  final String id;
  final String message;
  final bool isMe;

  const Chat({required this.id, required this.message, required this.isMe});
}
