import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/use_cases/signin_usecases.dart';
import '../../../domain/use_cases/signup_usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;

  AuthBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
  }) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
  }

  void _onSignInRequested(SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signInUseCase(event.email, event.password);
      if (user != null) {
        emit(Authenticated(user.uid));
      } else {
        emit(Unauthenticated("Sign in failed"));
      }
    } catch (e) {
      emit(Unauthenticated(e.toString()));
    }
  }

  void _onSignUpRequested(SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signUpUseCase(event.email, event.password);
      if (user != null) {
        emit(Authenticated(user.uid));
      } else {
        emit(Unauthenticated("Sign up failed"));
      }
    } catch (e) {
      emit(Unauthenticated(e.toString()));
    }
  }
}
