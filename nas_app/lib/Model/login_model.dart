class Login {
  String? phone;
  String? password;
  String? token;

  Login({this.phone, this.password, this.token});

  Login.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
    token = json['data']['token'];
  }

  @override
  String toString() {
    return 'Login{phone: $phone, password: $password, token: $token}';
  }
}
