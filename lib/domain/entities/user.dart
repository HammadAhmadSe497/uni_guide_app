class User {
  final String uid;
  final String? email;
  final String? name;

  User({
    required this.uid,
    this.email,
    this.name,
  });

  User copyWith({
    String? uid,
    String? email,
    String? name,
  }) {
    return User(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
