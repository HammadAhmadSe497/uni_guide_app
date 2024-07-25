abstract class SignUpEvent {}

class SignUpRequired extends SignUpEvent {
  final String email;
  final String password;
  final String name;

  SignUpRequired(this.email, this.password, this.name);
}
