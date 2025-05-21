import 'package:chat_app/constants.dart';

class Message {
  final String message;
  final String id;

  Message( this.message, this.id);

  factory Message.fromjson(jsData){
    return Message(jsData[kMessage],jsData['id']);
  }
}