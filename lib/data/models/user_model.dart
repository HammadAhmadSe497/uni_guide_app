import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required String uid,
    required String email,
  }) : super(
    uid: uid,
    email: email,
  );

  factory UserModel.fromFirebase(firebase_auth.User firebaseUser) {
    return UserModel(
      uid: firebaseUser.uid,
      email: firebaseUser.email ?? '',
    );
  }
}
