import 'package:flutter/material.dart';

class Comments {
  final int? postId;
  final int? id;
  final String? name;
  final String? email;
  final String? body;

  Comments({
    @required this.postId,
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.body,
  });

  static Comments fromMap(Map<String, dynamic>? data) {
    return Comments(
      postId: data!["postId"],
      id: data["id"],
      name: data["name"],
      email: data["email"],
      body: data['body'],
    );
  }
}
