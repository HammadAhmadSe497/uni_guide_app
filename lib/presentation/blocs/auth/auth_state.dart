part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final String uid;

  const Authenticated(this.uid);

  @override
  List<Object> get props => [uid];
}

class Unauthenticated extends AuthState {
  final String message;

  const Unauthenticated(this.message);

  @override
  List<Object> get props => [message];
}
