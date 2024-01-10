import 'package:flutter/material.dart';

class User {
  final int? id;
  final String? name;
  final String? username;
  final String? email;

  User({
    @required this.id,
    @required this.name,
    @required this.username,
    @required this.email,
  });

  static User fromMap(Map<String, dynamic>? data) {
    return User(
      id: data!["id"],
      name: data["name"],
      username: data["username"],
      email: data['email'],
    );
  }
}
