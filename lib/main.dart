import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uni_guide_app/domain/use_cases/signin_usecases.dart';
import 'package:uni_guide_app/presentation/blocs/auth/auth_bloc.dart';
import 'package:uni_guide_app/presentation/screens/home_screen.dart';
import 'package:uni_guide_app/presentation/screens/signin_screen.dart';

import 'data/data_sources/firebase_auth_datasource.dart';
import 'data/repositories/auth_repo_impl.dart';
import 'domain/use_cases/signup_usecases.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyC9qB-ycyl3zRecWKQ9G4cr7Of8Loro1tM",
          authDomain: "uni-guide-firebase.firebaseapp.com",
          projectId: "uni-guide-firebase",
          storageBucket: "uni-guide-firebase.appspot.com",
          messagingSenderId: "344607137409",
          appId: "1:344607137409:web:de3d14b6b5b048416b3780"
      ),
    );
  }
  else{
    await Firebase.initializeApp();
  }

  final firebaseAuthDataSource = FirebaseAuthDataSource(FirebaseAuth.instance);
  final authRepository = AuthRepositoryImpl(firebaseAuthDataSource);

  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;

  MyApp({required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            signInUseCase: SignInUseCase(authRepository),
            signUpUseCase: SignUpUseCase(authRepository),
          ),
        ),
      ],
      child: MaterialApp(
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return HomeScreen();  // Replace with your home screen
            } else {
              return SignInScreen();
            }
          },
        ),
      ),
    );
  }
}
