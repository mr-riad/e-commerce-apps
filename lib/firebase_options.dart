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
    apiKey: 'AIzaSyBx-B1pEnSDDQJTEPOMKri2MW9ayEwPuLg',
    appId: '1:1085058100211:web:93be5610cbdff667350086',
    messagingSenderId: '1085058100211',
    projectId: 'e-commerce-apps-e17d8',
    authDomain: 'e-commerce-apps-e17d8.firebaseapp.com',
    storageBucket: 'e-commerce-apps-e17d8.firebasestorage.app',
    measurementId: 'G-2HDSK0J42J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHShY6mhyTG5BZNv3c8g0sBiPDK9KRXFs',
    appId: '1:1085058100211:android:0688ac7678ee9fc6350086',
    messagingSenderId: '1085058100211',
    projectId: 'e-commerce-apps-e17d8',
    storageBucket: 'e-commerce-apps-e17d8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCAA08-SZSdw5D1SExaMVMZR3YjCJfkLTE',
    appId: '1:1085058100211:ios:b8171090da657be3350086',
    messagingSenderId: '1085058100211',
    projectId: 'e-commerce-apps-e17d8',
    storageBucket: 'e-commerce-apps-e17d8.firebasestorage.app',
    iosBundleId: 'com.example.eCommerceApps',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCAA08-SZSdw5D1SExaMVMZR3YjCJfkLTE',
    appId: '1:1085058100211:ios:b8171090da657be3350086',
    messagingSenderId: '1085058100211',
    projectId: 'e-commerce-apps-e17d8',
    storageBucket: 'e-commerce-apps-e17d8.firebasestorage.app',
    iosBundleId: 'com.example.eCommerceApps',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBx-B1pEnSDDQJTEPOMKri2MW9ayEwPuLg',
    appId: '1:1085058100211:web:50efe3dd8536eefc350086',
    messagingSenderId: '1085058100211',
    projectId: 'e-commerce-apps-e17d8',
    authDomain: 'e-commerce-apps-e17d8.firebaseapp.com',
    storageBucket: 'e-commerce-apps-e17d8.firebasestorage.app',
    measurementId: 'G-WYC66RWWX3',
  );
}
