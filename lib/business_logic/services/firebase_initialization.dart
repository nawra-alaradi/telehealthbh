import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  // bool _initialized = false;

  // Define an async function to initialize FlutterFire
  Future<void> initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      // _initialized = true;
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      print('error occured');
    }
  }
}
