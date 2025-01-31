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
    apiKey: 'AIzaSyA9UZfhxfN9Yn4bMSid3bbeZr8U7EKGTmY',
    appId: '1:643765076631:web:20701e45063d3554969fd2',
    messagingSenderId: '643765076631',
    projectId: 'carbon-fire',
    authDomain: 'carbon-fire.firebaseapp.com',
    storageBucket: 'carbon-fire.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBYSKoP7Qhd6pJOXSEkurbwYnooGfAxWK8',
    appId: '1:643765076631:android:a8bb26e7eb29385d969fd2',
    messagingSenderId: '643765076631',
    projectId: 'carbon-fire',
    storageBucket: 'carbon-fire.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-4xYKgD4x6CKSEQwWIATjIsm0ulxERYQ',
    appId: '1:643765076631:ios:1f32f4719a51593e969fd2',
    messagingSenderId: '643765076631',
    projectId: 'carbon-fire',
    storageBucket: 'carbon-fire.appspot.com',
    iosBundleId: 'com.example.carbon',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-4xYKgD4x6CKSEQwWIATjIsm0ulxERYQ',
    appId: '1:643765076631:ios:1f32f4719a51593e969fd2',
    messagingSenderId: '643765076631',
    projectId: 'carbon-fire',
    storageBucket: 'carbon-fire.appspot.com',
    iosBundleId: 'com.example.carbon',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA9UZfhxfN9Yn4bMSid3bbeZr8U7EKGTmY',
    appId: '1:643765076631:web:2376865adba2887c969fd2',
    messagingSenderId: '643765076631',
    projectId: 'carbon-fire',
    authDomain: 'carbon-fire.firebaseapp.com',
    storageBucket: 'carbon-fire.appspot.com',
  );
}
