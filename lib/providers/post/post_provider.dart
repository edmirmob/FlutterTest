import 'dart:async';
import 'package:flutter_test_1/core/models/posts.dart';
import 'package:flutter_test_1/core/repositories/post_repository.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../common/alert_dialog.dart';

import 'post_state.dart';

class PostProvider extends StateNotifier<PostState> with LocatorMixin {
  StreamSubscription? _filterSubscription;
  PostProvider() : super(PostInitialState());

  bool isPostLoaded() {
    return state.posts.isNotEmpty;
  }

  Future<void> loadPosts() async {
    if (!state.inProgress) {
      try {
        state = state.copyWith(loadingFirstPage: true, inProgress: true);
        const userId = -1;
        final result = await _getPost(
          userId,
        );
        state = state.copyWith(
          loadingFirstPage: false,
          inProgress: false,
          posts: [...result],
          totalCount: 100,
          userId: userId,
        );
      } catch (_) {
        _onPostsLoadingError();
      }
    }
  }

  Future<void> searchPosts(int userId, String search) async {
    state = state.copyWith(
      userId: userId,
      search: search,
      loadingFirstPage: true,
      inProgress: true,
    );

    _filterSubscription?.cancel();

    _filterSubscription = Stream.fromFuture(
      _getPost(userId),
    ).listen(
      (result) {
        state = state.copyWith(
          loadingFirstPage: false,
          inProgress: false,
          posts: [...result],
          totalCount: 100,
          userId: userId,
        );
      },
    );
  }

  Future<void> refreshPosts() async {
    if (!state.inProgress) {
      try {
        state = state.copyWith(inProgress: true);
        const userId = -1;
        final result = await _getPost(
          userId,
        );
        state = state.copyWith(
            inProgress: false, posts: [...result], userId: userId);
      } catch (_) {
        _onPostsLoadingError();
      }
    }
  }

  Future<List<Post>> _getPost(
    int userId,
  ) {
    return read<PostRepository>().getPosts(
      userId,
    );
  }

  void _onPostsLoadingError() {
    state = state.copyWith(inProgress: false);
    showAlertDialog('Can\'t load posts',
        'There was an error while loading posts. Please try again later.');
  }
}
