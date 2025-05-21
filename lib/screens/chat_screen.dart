// ignore_for_file: must_be_immutable

import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  static String id = 'ChatScreen';
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessageCollections,
  );
  TextEditingController controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt,descending: true).snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  if (snapshot.connectionState == ConnectionState.waiting) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  if (snapshot.hasError) {
    return const Scaffold(
      body: Center(
        child: Text('Something went wrong. Please try again later.'),
      ),
    );
  }

  if (snapshot.hasData) {
    List<Message> messagesList = [];
    for (int i = 0; i < snapshot.data!.docs.length; i++) {
      messagesList.add(Message.fromjson(snapshot.data!.docs[i]));
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPrimaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(kLogo, height: 50), Text('Chat')],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: _scrollController,
              itemCount: messagesList.length,
              itemBuilder: (BuildContext context, int index) {
                return ChatBubble(message: messagesList[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                messages.add({
                  kMessage: data,
                  kCreatedAt: DateTime.now(),
                });
                controller.clear();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollController.animateTo(
                    0,
                    duration: Duration(seconds: 1),
                    curve: Curves.easeOut,
                  );
                });
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: Icon(Icons.send, color: kPrimaryColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: kPrimaryColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  } else {
    return const Scaffold(
      body: Center(
        child: Text('No messages yet.'),
      ),
    );
  }
}
);
  }
}
