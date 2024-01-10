import 'package:flutter_test_1/core/models/comments.dart';

import '../../common/http.dart';

import '../../environment_config.dart';

class CommentsService with Http {
  Future<List<Comments>> getComments(
    int id,
  ) async {
    final result = await get('${EnvironmentConfig.apiUrl}/posts/$id/comments');

    var entities = result as List<dynamic>;
    var items = <Comments>[];
    for (var entity in entities) {
      items.add(
        Comments.fromMap(entity),
      );
    }

    return items;
  }
}
