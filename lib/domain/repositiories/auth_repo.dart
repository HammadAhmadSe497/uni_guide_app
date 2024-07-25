import '../entities/user.dart';

abstract class AuthRepository {
  Future<User?> signIn(String email, String password);
  Future<User?> signUp(String email, String password);
  Future<void> signOut();
  // User? getCurrentUser();
  Stream<User?> get user;

  setUserData(User? user) {} // Added user stream
}
