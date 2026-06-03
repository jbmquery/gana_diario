// lib/firebase_options.dart
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
    apiKey: 'AIzaSyAhK0lk3vsHmY_2KpOBWtCDOL_CTi7AKj0',
    appId: '1:705778651421:web:07e9f1b2d06377c9bd91f4',
    messagingSenderId: '705778651421',
    projectId: 'ganadiariojbm',
    authDomain: 'ganadiariojbm.firebaseapp.com',
    storageBucket: 'ganadiariojbm.firebasestorage.app',
    measurementId: 'G-Y4Z2WC4296',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCf4PMhPeWf31XE8_tYIZMHGwpOP0CT_yI',
    appId: '1:705778651421:android:79e1b93684e3cc49bd91f4',
    messagingSenderId: '705778651421',
    projectId: 'ganadiariojbm',
    storageBucket: 'ganadiariojbm.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaViZQhxxQVhIZzSwvSL3jQnxe4qIeFdc',
    appId: '1:705778651421:ios:f40d743685cc9e9cbd91f4',
    messagingSenderId: '705778651421',
    projectId: 'ganadiariojbm',
    storageBucket: 'ganadiariojbm.firebasestorage.app',
    iosClientId: '705778651421-jcrrpdkpfavf9eq6f1ltqnbnpvmtsolb.apps.googleusercontent.com',
    iosBundleId: 'com.example.ganaDiarioJbm',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBaViZQhxxQVhIZzSwvSL3jQnxe4qIeFdc',
    appId: '1:705778651421:ios:f40d743685cc9e9cbd91f4',
    messagingSenderId: '705778651421',
    projectId: 'ganadiariojbm',
    storageBucket: 'ganadiariojbm.firebasestorage.app',
    iosClientId: '705778651421-jcrrpdkpfavf9eq6f1ltqnbnpvmtsolb.apps.googleusercontent.com',
    iosBundleId: 'com.example.ganaDiarioJbm',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAhK0lk3vsHmY_2KpOBWtCDOL_CTi7AKj0',
    appId: '1:705778651421:web:27959dc2f51ef05ebd91f4',
    messagingSenderId: '705778651421',
    projectId: 'ganadiariojbm',
    authDomain: 'ganadiariojbm.firebaseapp.com',
    storageBucket: 'ganadiariojbm.firebasestorage.app',
    measurementId: 'G-TECL87ZVLF',
  );

}