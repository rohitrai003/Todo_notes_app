class UserSignInModel {
  final String email;
  final String password;

  UserSignInModel({
    required this.email,
    required this.password,
  });

  Map<String, String> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
