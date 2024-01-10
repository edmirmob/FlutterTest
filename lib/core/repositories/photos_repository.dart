import 'package:flutter_test_1/core/models/photos.dart';

import '../../common/http.dart';

import '../../environment_config.dart';

class PhotosRepository with Http {
  Future<List<Photos>> getPhotos(
    int limit,
    int page,
  ) async {
    final result = await get(
        '${EnvironmentConfig.apiUrl}/photos?_limit=$limit&_page=$page');

    var entities = result as List<dynamic>;
    var items = <Photos>[];
    for (var entity in entities) {
      items.add(
        Photos.fromMap(entity),
      );
    }

    return items;
  }
}
