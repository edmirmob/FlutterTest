import 'package:flutter/material.dart';

class Photos {
  final int? albumId;
  final int? id;
  final String? title;
  final String? url;
  final String? thumbnailUrl;

  Photos(
      {@required this.albumId,
      @required this.id,
      @required this.title,
      @required this.url,
      @required this.thumbnailUrl});

  static Photos fromMap(Map<String, dynamic>? data) {
    return Photos(
      albumId: data!["albumId"],
      id: data["id"],
      title: data["title"],
      url: data['url'],
      thumbnailUrl: data['thumbnailUrl'],
    );
  }
}
