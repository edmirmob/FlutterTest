import 'package:flutter_test_1/core/models/posts.dart';

import '../../common/http.dart';

import '../../environment_config.dart';

class PostRepository with Http {
  Future<List<Post>> getPosts(
    int userId,
  ) async {
    final result = await get(
        '${EnvironmentConfig.apiUrl}${userId >= 0 ? '/users/$userId' : ''}/posts');

    var entities = result as List<dynamic>;
    var items = <Post>[];
    for (var entity in entities) {
      items.add(
        Post.fromMap(entity),
      );
    }

    return items;
  }
}
