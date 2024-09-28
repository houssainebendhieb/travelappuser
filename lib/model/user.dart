class User {
  String email;
  String password;
  User({ required this.email, required this.password});

  get getEmail => email;
  get getPassword => password;
}
