// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAAMvnH4h3V6Q8io4xM1CAGwGyiF_V6yc8',
    appId: '1:297872002285:web:0a0ede4b5aa21c28b950e4',
    messagingSenderId: '297872002285',
    projectId: 'gaseng',
    authDomain: 'gaseng.firebaseapp.com',
    storageBucket: 'gaseng.appspot.com',
    measurementId: 'G-VXZ9QGF8CN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMPkslOe_wtqnc6H3hMyGhRhjmAhgs7FU',
    appId: '1:297872002285:android:432655bba4f8eb88b950e4',
    messagingSenderId: '297872002285',
    projectId: 'gaseng',
    storageBucket: 'gaseng.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBEUBu-FgjvxrH6bgYR4u1WDLjXAI0QwfI',
    appId: '1:297872002285:ios:083c0b334b33c6f4b950e4',
    messagingSenderId: '297872002285',
    projectId: 'gaseng',
    storageBucket: 'gaseng.appspot.com',
    iosBundleId: 'com.application.gaseng',
  );
}