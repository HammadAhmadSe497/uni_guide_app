import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/entities/user.dart';
import '../../domain/repositiories/auth_repo.dart';
import '../data_sources/firebase_auth_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final FirebaseAuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<User?> signIn(String email, String password) async {
    final firebase_auth.User? user = await _dataSource.signIn(email, password);
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  @override
  Future<User?> signUp(String email, String password) async {
    final firebase_auth.User? user = await _dataSource.signUp(email, password);
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }

  @override
  Future<void> signOut() async {
    await _dataSource.signOut();
  }

  @override
  User? getCurrentUser() {
    final firebase_auth.User? user = _dataSource.getCurrentUser();
    return user != null ? UserModel.fromFirebaseUser(user) : null;
  }
}
