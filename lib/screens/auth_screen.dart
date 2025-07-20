import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_notify/easy_notify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogging = true; //is the program in the login step or signup
  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  final _formKey = GlobalKey<FormState>(); //the key to activate the validation
  bool _isLoading = false;

  //----------------------
  void _submit() async {
    final valid = _formKey.currentState!.validate(); //make the validation

    if (!valid) {
      return;
    }
    _formKey.currentState!.save();

    //try to send the data to the firebase
    try {
      setState(() {
        _isLoading = true;
      });
      //in case of login
      if (_isLogging) {

        final UserCredential userCredential =
            await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
            //!------------------
              //send notification
              EasyNotify.showRepeatedNotification(
                id: 1,
                title: 'Check your new messages',
                body: "see your new messages",
              );
        //in case of signup
      } else {
        final UserCredential userCredential =
            await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        //add the data to the collection 'firestore'
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
        });
      }
    } on FirebaseAuthException catch (e) {
      // Check if the widget is still mounted
      if (!mounted) return; //for 'context' "Chat GPT"
      ScaffoldMessenger.of(context)
          .clearSnackBars(); //to clear all the previous bars from the screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? 'Signup failed'),
          behavior: SnackBarBehavior.floating, // Makes it a floating SnackBar
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded edges
          ),
          margin: const EdgeInsets.all(16), // Adds margin around the SnackBar
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //image container
              margin: const EdgeInsets.only(
                top: 30,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              width: 200,
              child: Image.asset('assets/chat.png'),
            ),
            Card(
              //card that contains the form and fields
              margin: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    //decoration for gradient
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [Colors.cyan, Colors.lightGreen],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        _isLogging ? "Login" : "Signup",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Form(
                        key: _formKey, //the validator
                        //the form for credentials
                        child: Column(
                          children: [
                            //--user name
                            if (!_isLogging)
                              TextFormField(
                                  onSaved: (newValue) => _enteredUsername = newValue!,
                                  decoration: const InputDecoration(
                                    label: Text('Username'),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.trim().length < 3) {
                                      return 'Invalid username please enter at least 3 characters';
                                    }
                                    return null; // Input is valid
                                  }),
                            //--the email address field
                            TextFormField(
                              onSaved: (newValue) => _enteredEmail = newValue!,
                              decoration: const InputDecoration(
                                label: Text('Email'),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Email address is required';
                                }

                                // Regular expression for validating email
                                final emailRegex = RegExp(
                                    // used chap gpt for that
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                                if (!emailRegex.hasMatch(value)) {
                                  return 'Please enter a valid email address';
                                }

                                return null; // Input is valid
                              },
                            ),
                            //--the password field
                            TextFormField(
                              onSaved: (newValue) =>
                                  _enteredPassword = newValue!,
                              decoration: const InputDecoration(
                                label: Text('Password'),
                              ),
                              obscureText: true, //hide the text
                              validator: (value) {
                                if (value == null || value.trim().length < 6) {
                                  return 'Invalid password';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            if (_isLoading) const CircularProgressIndicator(),
                            if (!_isLoading)
                              // --login/signup button
                              ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent,
                                ),
                                child: Text(_isLogging ? 'Login' : 'Signup'),
                              ),
                            if (!_isLoading)
                              //--button to switch to login/signup
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isLogging = !_isLogging;
                                  });
                                },
                                child: Text(
                                  _isLogging
                                      ? 'Create an account'
                                      : 'I already have an account',
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
