class UserAuth {
  final String name;
  final String username;
  final String password;
  final String uid;

  UserAuth({
    required this.name,
    required this.username,
    required this.password,
    required this.uid,
  });

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      name: json['name'],
      username: json['username'],
      password: json['password'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'password': password,
      'uid': uid,
    };
  }
}
