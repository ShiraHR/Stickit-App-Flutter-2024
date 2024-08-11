import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAuqXy8f4pq__L2VHsEB4PmdrEHflaxIHc',
    appId: '1:1085285429009:android:8cb7816244da875a9e26b0',
    projectId: 'skitickapp-12931',
    messagingSenderId: '1085285429009',
    storageBucket: 'skitickapp-12931.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyAsvHaSkZrjLdR9lNY2qaGkOn4ysTkOv1A",
      authDomain: "skitickapp-12931.firebaseapp.com",
      projectId: "skitickapp-12931",
      storageBucket: "skitickapp-12931.appspot.com",
      messagingSenderId: "1085285429009",
      appId: "1:1085285429009:web:15c10aef913de8239e26b0");
}

