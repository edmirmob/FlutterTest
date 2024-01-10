import 'dart:async';

import 'package:flutter_test_1/core/models/users.dart';

import 'package:flutter_test_1/core/repositories/users_repository.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../common/alert_dialog.dart';

import 'user_state.dart';

class UserProvider extends StateNotifier<UserState> with LocatorMixin {
  UserProvider() : super(UserInitialState());

  Future<void> loadUsers() async {
    if (!state.inProgress) {
      try {
        state = state.copyWith(loadingFirstPage: true, inProgress: true);

        final result = await _getUsers();
        state = state.copyWith(
          loadingFirstPage: false,
          inProgress: false,
          users: [...result],
        );
      } catch (_) {
        _onUsersLoadingError();
      }
    }
  }

  Future<List<User>> _getUsers() {
    return read<UsersRepository>().getUsers();
  }

  void _onUsersLoadingError() {
    state = state.copyWith(inProgress: false);
    showAlertDialog('Can\'t load users',
        'There was an error while loading users. Please try again later.');
  }
}
