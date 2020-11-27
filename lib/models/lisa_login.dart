class LisaLogin {
  String username;
  String password;
  int id;

  LisaLogin(this.username, this.password);

  String get myUsername => this.username;

  String get myPassword => this.password;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'username': username,
      'password': password,
    };
    return map;
  }

  LisaLogin.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    username = map['username'];
    password = map['password'];
  }
}
