import 'package:flutter_test_1/core/models/posts.dart';

import '../../common/http.dart';

import '../../environment_config.dart';

class PostDetailsService with Http {
  Future<Post> getPostDetails(
    int id,
  ) async {
    final result = await get('${EnvironmentConfig.apiUrl}/posts/$id');

    Post item = Post.fromMap(result);

    return item;
  }
}
