import 'package:flutter_test_1/core/models/users.dart';

class UserState {
  final List<User> users;

  final String search;
  final bool loadingFirstPage;

  final bool inProgress;

  UserState({
    required this.users,
    required this.search,
    required this.loadingFirstPage,
    required this.inProgress,
  });

  UserState copyWith({
    List<User>? users,
    String? search,
    bool? loadingFirstPage,
    bool? inProgress,
  }) {
    return UserState(
      users: users ?? this.users,
      search: search ?? this.search,
      loadingFirstPage: loadingFirstPage ?? this.loadingFirstPage,
      inProgress: inProgress ?? this.inProgress,
    );
  }
}

class UserInitialState extends UserState {
  UserInitialState()
      : super(
          users: [],
          search: '',
          loadingFirstPage: false,
          inProgress: false,
        );
}
