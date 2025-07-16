import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  //--------------------
  _sendMessage() async {
    final enteredMessage = _messageController.text;
    if (enteredMessage.trim().isEmpty) {
      return;
    }
    final User? user =
        FirebaseAuth.instance.currentUser; //gets the current user

    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    await FirebaseFirestore.instance.collection('chat').add({
      'message': enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
    });

    _messageController.clear(); //empty the field after sending the message
  }

  //--------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 14, top: 1),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              enableSuggestions: true,
              decoration: InputDecoration(
                hintText: 'Send a message...',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      BorderSide.none, // Remove border lines for a clean look
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send,
                      color: Theme.of(context).colorScheme.primary),
                  onPressed: _sendMessage,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
