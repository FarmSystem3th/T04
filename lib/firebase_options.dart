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
    apiKey: 'AIzaSyAjGATgWheqjQXXAxBCwzeQMIRbmQFu8QI',
    appId: '1:319208159170:web:fc7bdbf3cd65d5f9c8085b',
    messagingSenderId: '319208159170',
    projectId: 'jocheong-30939',
    authDomain: 'jocheong-30939.firebaseapp.com',
    storageBucket: 'jocheong-30939.appspot.com',
    measurementId: 'G-BBQFHV198F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNnPoDmQwmhqg8vVQ4PSmb0MujHQUO-NU',
    appId: '1:319208159170:android:407648f462f58cb3c8085b',
    messagingSenderId: '319208159170',
    projectId: 'jocheong-30939',
    storageBucket: 'jocheong-30939.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAspJQvUisuAdUnV5M6iBgwCKLWb02utOc',
    appId: '1:319208159170:ios:020d533c98907465c8085b',
    messagingSenderId: '319208159170',
    projectId: 'jocheong-30939',
    storageBucket: 'jocheong-30939.appspot.com',
    iosClientId: '319208159170-ll2auv1144241369adkijpr0pubblp7r.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAspJQvUisuAdUnV5M6iBgwCKLWb02utOc',
    appId: '1:319208159170:ios:020d533c98907465c8085b',
    messagingSenderId: '319208159170',
    projectId: 'jocheong-30939',
    storageBucket: 'jocheong-30939.appspot.com',
    iosClientId: '319208159170-ll2auv1144241369adkijpr0pubblp7r.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAjGATgWheqjQXXAxBCwzeQMIRbmQFu8QI',
    appId: '1:319208159170:web:e0fcdf11068a5f8dc8085b',
    messagingSenderId: '319208159170',
    projectId: 'jocheong-30939',
    authDomain: 'jocheong-30939.firebaseapp.com',
    storageBucket: 'jocheong-30939.appspot.com',
    measurementId: 'G-379Z23GY2F',
  );

}