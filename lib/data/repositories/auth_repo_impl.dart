import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:uni_guide_app/domain/entities/user.dart';
import 'package:uni_guide_app/domain/entities/user.dart' as domain_user;
import '../../domain/repositiories/auth_repo.dart';

class FirebaseAuthRepository implements AuthRepository {
  final firebase.FirebaseAuth _firebaseAuth;

  FirebaseAuthRepository({firebase.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase.FirebaseAuth.instance;

  @override
  Future<User?> signIn(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(userCredential.user);
  }

  @override
  Future<User?> signUp(String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirebase(userCredential.user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  // @override
  // User? getCurrentUser() {
  //   return _userFromFirebase(_firebaseAuth.currentUser);
  // }

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  User? _userFromFirebase(firebase.User? user) {
    if (user == null) return null;
    return User(
      uid: user.uid,
      email: user.email,
    );
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

}
