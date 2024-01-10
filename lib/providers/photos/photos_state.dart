import 'package:flutter_test_1/core/models/photos.dart';

class PhotosState {
  final List<Photos> photos;
  final int page;
  final int limit;

  final bool loadingFirstPage;
  final bool loadingMoreData;
  final bool inProgress;

  PhotosState({
    required this.photos,
    required this.page,
    required this.limit,
    required this.loadingFirstPage,
    required this.loadingMoreData,
    required this.inProgress,
  });

  PhotosState copyWith({
    List<Photos>? photos,
    int? page,
    int? limit,
    String? search,
    bool? loadingFirstPage,
    bool? loadingMoreData,
    bool? inProgress,
  }) {
    return PhotosState(
      photos: photos ?? this.photos,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      loadingFirstPage: loadingFirstPage ?? this.loadingFirstPage,
      loadingMoreData: loadingMoreData ?? this.loadingMoreData,
      inProgress: inProgress ?? this.inProgress,
    );
  }
}

class PhotosInitialState extends PhotosState {
  PhotosInitialState()
      : super(
          photos: [],
          page: -1,
          limit: -1,
          loadingFirstPage: false,
          loadingMoreData: false,
          inProgress: false,
        );
}
