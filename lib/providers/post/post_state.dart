import 'package:flutter_test_1/core/models/posts.dart';

class PostState {
  final List<Post> posts;
  final int userId;

  final String search;
  final bool loadingFirstPage;
  final bool loadingMoreData;
  final bool inProgress;

  PostState({
    required this.posts,
    required this.userId,
    required this.search,
    required this.loadingFirstPage,
    required this.loadingMoreData,
    required this.inProgress,
  });

  PostState copyWith({
    List<Post>? posts,
    int? userId,
    int? totalCount,
    String? search,
    bool? loadingFirstPage,
    bool? loadingMoreData,
    bool? inProgress,
  }) {
    return PostState(
      posts: posts ?? this.posts,
      userId: userId ?? this.userId,
      search: search ?? this.search,
      loadingFirstPage: loadingFirstPage ?? this.loadingFirstPage,
      loadingMoreData: loadingMoreData ?? this.loadingMoreData,
      inProgress: inProgress ?? this.inProgress,
    );
  }
}

class PostInitialState extends PostState {
  PostInitialState()
      : super(
          posts: [],
          userId: -1,
          search: '',
          loadingFirstPage: false,
          loadingMoreData: false,
          inProgress: false,
        );
}
