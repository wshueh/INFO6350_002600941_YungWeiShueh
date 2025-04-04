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
    apiKey: 'AIzaSyA0YAJ2QZR1TwtN8eV-JlPK6eto1F234vY',
    appId: '1:828349313969:web:30147c1b81f9adc0510390',
    messagingSenderId: '828349313969',
    projectId: 'auth-spring2025-305e6',
    authDomain: 'auth-spring2025-305e6.firebaseapp.com',
    storageBucket: 'auth-spring2025-305e6.firebasestorage.app',
    measurementId: 'G-WR6Z5SGMSG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAtEFhD1ZvqL0RAUX4Ykrkkl5aEoqvFwyw',
    appId: '1:828349313969:android:569f1a46b67df603510390',
    messagingSenderId: '828349313969',
    projectId: 'auth-spring2025-305e6',
    storageBucket: 'auth-spring2025-305e6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAZvkqtEALBK55-VpJgi4WYQ5TQUKhT7A',
    appId: '1:828349313969:ios:d3e59517eabaf8da510390',
    messagingSenderId: '828349313969',
    projectId: 'auth-spring2025-305e6',
    storageBucket: 'auth-spring2025-305e6.firebasestorage.app',
    iosClientId: '828349313969-6ogoug9goiqadvtgidbmkdj0j97t802s.apps.googleusercontent.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCAZvkqtEALBK55-VpJgi4WYQ5TQUKhT7A',
    appId: '1:828349313969:ios:d3e59517eabaf8da510390',
    messagingSenderId: '828349313969',
    projectId: 'auth-spring2025-305e6',
    storageBucket: 'auth-spring2025-305e6.firebasestorage.app',
    iosClientId: '828349313969-6ogoug9goiqadvtgidbmkdj0j97t802s.apps.googleusercontent.com',
    iosBundleId: 'com.example.myApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA0YAJ2QZR1TwtN8eV-JlPK6eto1F234vY',
    appId: '1:828349313969:web:030e270a8b59aa83510390',
    messagingSenderId: '828349313969',
    projectId: 'auth-spring2025-305e6',
    authDomain: 'auth-spring2025-305e6.firebaseapp.com',
    storageBucket: 'auth-spring2025-305e6.firebasestorage.app',
    measurementId: 'G-XR7JT7G79T',
  );

}