import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uni_guide_app/presentation/blocs/sign_up_bloc/sign_up_event.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/repositiories/auth_repo.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
	final AuthRepository _userRepository;

  SignUpBloc({
		required AuthRepository userRepository
	}) : _userRepository = userRepository,
		super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
			emit(SignUpProcess());
			try {
        User? user = await _userRepository.signUp(event.email, event.password);
				await _userRepository.setUserData(user);
				emit(SignUpSuccess());
      } catch (e) {
				emit(SignUpFailure());
      }
    });
  }
}
