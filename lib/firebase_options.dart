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
    apiKey: 'AIzaSyBtx5Uxwwgvqkb7Ah90TK4jmtVecSWC2yM',
    appId: '1:993899381675:web:6cba79347b2797540348ee',
    messagingSenderId: '993899381675',
    projectId: 'atividadep2-d1d26',
    authDomain: 'atividadep2-d1d26.firebaseapp.com',
    storageBucket: 'atividadep2-d1d26.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPrGB1aZlK7H4K0TRIk-FerE6aOBAkZ3s',
    appId: '1:993899381675:android:eedd019e390c87190348ee',
    messagingSenderId: '993899381675',
    projectId: 'atividadep2-d1d26',
    storageBucket: 'atividadep2-d1d26.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDR2mDmMlRtQ9sCvR0-KneL9rTBZOrdPng',
    appId: '1:993899381675:ios:e49b3ac0d57286d60348ee',
    messagingSenderId: '993899381675',
    projectId: 'atividadep2-d1d26',
    storageBucket: 'atividadep2-d1d26.firebasestorage.app',
    iosClientId: '993899381675-8ad5h4l36e4gkel4kehjoipc9i6efati.apps.googleusercontent.com',
    iosBundleId: 'br.unigran.projetoP2v2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDR2mDmMlRtQ9sCvR0-KneL9rTBZOrdPng',
    appId: '1:993899381675:ios:e49b3ac0d57286d60348ee',
    messagingSenderId: '993899381675',
    projectId: 'atividadep2-d1d26',
    storageBucket: 'atividadep2-d1d26.firebasestorage.app',
    iosClientId: '993899381675-8ad5h4l36e4gkel4kehjoipc9i6efati.apps.googleusercontent.com',
    iosBundleId: 'br.unigran.projetoP2v2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBtx5Uxwwgvqkb7Ah90TK4jmtVecSWC2yM',
    appId: '1:993899381675:web:0e4d98a61498106c0348ee',
    messagingSenderId: '993899381675',
    projectId: 'atividadep2-d1d26',
    authDomain: 'atividadep2-d1d26.firebaseapp.com',
    storageBucket: 'atividadep2-d1d26.firebasestorage.app',
  );
}
