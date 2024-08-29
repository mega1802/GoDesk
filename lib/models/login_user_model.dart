class LoginUser {
  final String email;
  final String password;

  LoginUser({
    required this.email,
    required this.password,
  });

  // Convert a LoginUser into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return 'LoginUser{email: $email, password: $password}';
  }
}
