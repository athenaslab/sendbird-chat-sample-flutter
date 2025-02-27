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
    apiKey: 'AIzaSyA5ZNSiZU_nacDCWOLTOV4lJAYjK2BNBw4',
    appId: '1:922365158617:web:4b284608db48ddc2188ac8',
    messagingSenderId: '922365158617',
    projectId: 'sendbird-sample-v2',
    authDomain: 'sendbird-sample-v2.firebaseapp.com',
    storageBucket: 'sendbird-sample-v2.appspot.com',
    measurementId: 'G-TWW31XV9EM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGlgMg3CKUDutQ-CsNR_vL2-2WLld2ODQ',
    appId: '1:922365158617:android:4e6c26b583ddc839188ac8',
    messagingSenderId: '922365158617',
    projectId: 'sendbird-sample-v2',
    storageBucket: 'sendbird-sample-v2.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCEooXHnbiM3BMM3XQqK51cqkWPNvwegXQ',
    appId: '1:922365158617:ios:2a7cf381883d279d188ac8',
    messagingSenderId: '922365158617',
    projectId: 'sendbird-sample-v2',
    storageBucket: 'sendbird-sample-v2.appspot.com',
    iosClientId: '922365158617-fk7c64ua9el8c7caqk2e6bnrif88ln96.apps.googleusercontent.com',
    iosBundleId: 'com.sendbird.sv2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCEooXHnbiM3BMM3XQqK51cqkWPNvwegXQ',
    appId: '1:922365158617:ios:64133bd193b5b8ef188ac8',
    messagingSenderId: '922365158617',
    projectId: 'sendbird-sample-v2',
    storageBucket: 'sendbird-sample-v2.appspot.com',
    iosClientId: '922365158617-40nn8bvs751j02puhh0q6s1urfntnprr.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );
}
