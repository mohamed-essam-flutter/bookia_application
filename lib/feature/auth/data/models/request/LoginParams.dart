class LoginParams {
  String? name;
  String? password;
  LoginParams({this.name, this.password});
  Map<String, dynamic> toJson() {
    return {"email": name, "password": password};
  }
}
