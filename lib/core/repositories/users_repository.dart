import 'package:flutter_test_1/core/models/users.dart';

import '../../common/http.dart';

import '../../environment_config.dart';

class UsersRepository with Http {
  Future<List<User>> getUsers() async {
    final result = await get('${EnvironmentConfig.apiUrl}/users');

    var entities = result as List<dynamic>;
    var items = <User>[];
    for (var entity in entities) {
      items.add(
        User.fromMap(entity),
      );
    }

    return items;
  }
}
