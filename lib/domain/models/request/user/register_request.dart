class RegisterRequest {
  final String name;
  final String email;
  final String? tel;
  final String password;

  RegisterRequest({
    required this.name,
    required this.email,
    this.tel,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'tel': tel, 'password': password};
  }
}
