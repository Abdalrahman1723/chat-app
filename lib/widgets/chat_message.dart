import 'package:chat/widgets/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final authUser = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('No message found.'),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong!...'),
          );
        }

        final loadedMessages = snapshot.data!.docs;

        return ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 40,
            left: 12,
            right: 12,
          ),
          reverse: true,
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) {
            final chatMessage = loadedMessages[index].data();
            final nextMessage = index + 1 < loadedMessages.length
                ? loadedMessages[index + 1].data()
                : null;

            final currentMessageUserId = chatMessage['userId'];
            final nextMessageUserId =
                nextMessage != null ? nextMessage['userId'] : null;

            final bool isNextUserIsSame =
                nextMessageUserId == currentMessageUserId;
            //---------------------- call the message bubble
            if (isNextUserIsSame) {
              return MessageBubble.next(
                  message: chatMessage['message'],
                  isMe: authUser.uid == currentMessageUserId);
            } else {
              return MessageBubble.first(
                  username: chatMessage['username'],
                  message: chatMessage['message'],
                  isMe: authUser.uid == currentMessageUserId);
            }
          },
        );
      },
    );
  }
}
