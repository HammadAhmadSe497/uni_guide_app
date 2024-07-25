import 'package:uni_guide_app/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/data_sources/firebase_auth_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// Correct path to FirebaseAuthDataSource


import 'app.dart';
import 'data/data_sources/firebase_auth_datasource.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyC9qB-ycyl3zRecWKQ9G4cr7Of8Loro1tM",
        authDomain: "uni-guide-firebase.firebaseapp.com",
        projectId: "uni-guide-firebase",
        storageBucket: "uni-guide-firebase.appspot.com",
        messagingSenderId: "344607137409",
        appId: "1:344607137409:web:de3d14b6b5b048416b3780",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  Bloc.observer = SimpleBlocObserver();
  final firebaseAuthInstance = firebase_auth.FirebaseAuth.instance;
  runApp(MyApp(FirebaseAuthDataSource( firebaseAuthInstance)));
}
