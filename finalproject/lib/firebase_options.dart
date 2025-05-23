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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBtToTSG1mWcNyIEalj4_jwNcnSB8UXbIA',
    appId: '1:703882766759:android:896b3e6778821a513f2e82',
    messagingSenderId: '703882766759',
    projectId: 'finalproject-002600941',
    storageBucket: 'finalproject-002600941.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYIWGG5u1objP_ghhNlS2w592aPtirVXY',
    appId: '1:703882766759:ios:24155a2eb7ba0a253f2e82',
    messagingSenderId: '703882766759',
    projectId: 'finalproject-002600941',
    storageBucket: 'finalproject-002600941.firebasestorage.app',
    androidClientId: '703882766759-j3eh1b2bg624p89u2qse3151vokq0lsr.apps.googleusercontent.com',
    iosClientId: '703882766759-fe1jqau611ktth950ovskvi84p7ralff.apps.googleusercontent.com',
    iosBundleId: 'com.example.finalproject',
  );

}