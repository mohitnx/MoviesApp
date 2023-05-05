// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String id;
  String token;
  String name;
  String password;
  String email;
  User({
    required this.id,
    required this.token,
    required this.name,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'name': name,
      'password': password,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      //mongo ma id is stored is _id
      id: map['_id'] as String,
      token: map['token'] as String,
      name: map['name'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
