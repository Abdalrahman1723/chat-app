// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDwDFgzohN9X0dEErDTJtGQOETWdXKh-Z4',
    appId: '1:831279466567:web:eff110bfef0a76bab88962',
    messagingSenderId: '831279466567',
    projectId: 'chat-61d52',
    authDomain: 'chat-61d52.firebaseapp.com',
    storageBucket: 'chat-61d52.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCpP6mCNZ4FQM-xvhTZTgzIDUX7a7-XrQA',
    appId: '1:831279466567:android:17dd4aa74a465055b88962',
    messagingSenderId: '831279466567',
    projectId: 'chat-61d52',
    storageBucket: 'chat-61d52.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBdI89I7SbD5Dy9MWblXUpkmDujS8FHNrU',
    appId: '1:831279466567:ios:ad7835b8b2a49a63b88962',
    messagingSenderId: '831279466567',
    projectId: 'chat-61d52',
    storageBucket: 'chat-61d52.firebasestorage.app',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBdI89I7SbD5Dy9MWblXUpkmDujS8FHNrU',
    appId: '1:831279466567:ios:ad7835b8b2a49a63b88962',
    messagingSenderId: '831279466567',
    projectId: 'chat-61d52',
    storageBucket: 'chat-61d52.firebasestorage.app',
    iosBundleId: 'com.example.chat',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDwDFgzohN9X0dEErDTJtGQOETWdXKh-Z4',
    appId: '1:831279466567:web:2fa138ce60de8561b88962',
    messagingSenderId: '831279466567',
    projectId: 'chat-61d52',
    authDomain: 'chat-61d52.firebaseapp.com',
    storageBucket: 'chat-61d52.firebasestorage.app',
  );
}
