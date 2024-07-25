import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:uni_guide_app/domain/entities/user.dart' as domain_user;
import 'package:uni_guide_app/domain/repositiories/auth_repo.dart';

import '../models/user_model.dart';
import '../repositories/auth_repo_impl.dart';

class FirebaseAuthDataSource implements FirebaseAuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  FirebaseAuthDataSource(this._firebaseAuth);

  Future<UserModel?> signIn(String email, String password) async {
    firebase_auth.UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Convert firebase_auth.User to UserModel
    if (userCredential.user != null) {
      return UserModel.fromFirebase(
          userCredential.user!); // Use UserModel explicitly
    }
    return null; // Return null if userCredential.user is null
  }

  Future<UserModel?> signUp(String email, String password) async {
    firebase_auth.UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Convert firebase_auth.User to UserModel
    if (userCredential.user != null) {
      return UserModel.fromFirebase(
          userCredential.user!); // Use UserModel explicitly
    }
    return null; // Return null if userCredential.user is null
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(domain_user.User? user) async {
    if (user != null && _firebaseAuth.currentUser != null) {
      await _firebaseAuth.currentUser!.updateProfile();
      // Optionally, update email or other properties as needed
    } else {
      throw Exception('User not found');
    }
  }


  @override
  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser != null) {
        return UserModel.fromFirebase(firebaseUser);
      }
      return null;
    });
  }

}

