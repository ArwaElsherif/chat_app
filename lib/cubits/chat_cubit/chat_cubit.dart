import 'package:bloc/bloc.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
   List<Message> messagesList = [];

  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessageCollections,
  );

  void sendMessage({required String message, required String email}) {
    messages.add({kMessage: message, kCreatedAt: DateTime.now(), 'id': email});
  }
 
  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
     messagesList.clear();
      for (int i = 0; i < event.docs.length; i++) {
        messagesList.add(Message.fromjson(event.docs[i]));
      }
      emit(ChatSuccess(messagesList));
    });
  }
}
