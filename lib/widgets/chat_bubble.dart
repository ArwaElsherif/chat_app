import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
   const ChatBubble({
    super.key,
    required this.message,
  });
 final Message message;
  @override
  Widget build(BuildContext context) {
   return Align(
  alignment: Alignment.centerLeft,
  child: Container(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    decoration: BoxDecoration(
      color: kPrimaryColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
        bottomRight: Radius.circular(32),
      ),
    ),
    child: Text(
      message.message,
      style: TextStyle(color: Colors.white),
    ),
  ),
);

  }
}