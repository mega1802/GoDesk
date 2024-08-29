class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String organizationName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.organizationName,
  });

  // Convert a User into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'organizationName': organizationName,
    };
  }

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, email: $email, password: $password, organizationName: $organizationName}';
  }
}
