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
        return macos;
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
    apiKey: 'AIzaSyDg1WvEKWSmabSLxv9wB9A8TA_CMDpgrNA',
    appId: '1:908664554105:web:7bbfd20aa43fd98470caa8',
    messagingSenderId: '908664554105',
    projectId: 'tiktuck-dd7c3',
    authDomain: 'tiktuck-dd7c3.firebaseapp.com',
    storageBucket: 'tiktuck-dd7c3.appspot.com',
    measurementId: 'G-G7H18S91ZQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBC_UUf7cZLOaEnJ4VCjSfHBewNBiNNqX8',
    appId: '1:908664554105:android:517b85f3aa8f8a5370caa8',
    messagingSenderId: '908664554105',
    projectId: 'tiktuck-dd7c3',
    storageBucket: 'tiktuck-dd7c3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnMbH4ZHgIpPC8ztBJ2YYEZDX_LqVDDsg',
    appId: '1:908664554105:ios:9b931461ef3fbc8b70caa8',
    messagingSenderId: '908664554105',
    projectId: 'tiktuck-dd7c3',
    storageBucket: 'tiktuck-dd7c3.appspot.com',
    iosClientId: '908664554105-sns2br7mgvct8tnckbotdll17pmmuivc.apps.googleusercontent.com',
    iosBundleId: 'com.example.tiktuck',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnMbH4ZHgIpPC8ztBJ2YYEZDX_LqVDDsg',
    appId: '1:908664554105:ios:f60cbd101671b99570caa8',
    messagingSenderId: '908664554105',
    projectId: 'tiktuck-dd7c3',
    storageBucket: 'tiktuck-dd7c3.appspot.com',
    iosClientId: '908664554105-k3vgdhqlfnjp9mo3ncpc5jdugdvm3hlo.apps.googleusercontent.com',
    iosBundleId: 'com.example.tiktuck.RunnerTests',
  );
}
