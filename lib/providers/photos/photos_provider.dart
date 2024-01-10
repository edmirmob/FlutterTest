import 'dart:async';
import 'package:flutter_test_1/core/models/photos.dart';
import 'package:flutter_test_1/core/repositories/photos_repository.dart';
import 'package:flutter_test_1/providers/photos/photos_state.dart';
import 'package:state_notifier/state_notifier.dart';

import '../../common/alert_dialog.dart';

class PhotosProvider extends StateNotifier<PhotosState> with LocatorMixin {
  StreamSubscription? _filterSubscription;
  PhotosProvider() : super(PhotosInitialState());

  Future<void> loadPhotos() async {
    if (!state.inProgress) {
      try {
        state = state.copyWith(loadingFirstPage: true, inProgress: true);
        const nextPage = 0;
        const limit = 10;
        final result = await _getPhotos(limit, nextPage);
        state = state.copyWith(
          loadingFirstPage: false,
          inProgress: false,
          photos: [...result],
          page: nextPage,
        );
      } catch (_) {
        _onPhotosLoadingError();
      }
    }
  }

  Future<void> filterPhoto(
    int limit,
  ) async {
    state = state.copyWith(
      limit: limit,
      loadingFirstPage: true,
      inProgress: true,
    );

    _filterSubscription?.cancel();
    const nextPage = 0;
    _filterSubscription = Stream.fromFuture(
      _getPhotos(limit, nextPage),
    ).listen(
      (result) {
        state = state.copyWith(
          loadingFirstPage: false,
          inProgress: false,
          photos: [...result],
          limit: limit,
        );
      },
    );
  }

  Future<void> loadMorePhotos() async {
    if (!state.inProgress && state.page > -1) {
      try {
        state = state.copyWith(loadingMoreData: true, inProgress: true);
        final nextPage = state.page + 1;
        final result = await _getPhotos(state.limit, nextPage);
        state = state.copyWith(
          loadingMoreData: false,
          inProgress: false,
          photos: [...state.photos, ...result],
          page: nextPage,
        );
      } catch (_) {
        _onPhotosLoadingError();
      }
    }
  }

  Future<List<Photos>> _getPhotos(int limit, int page) {
    return read<PhotosRepository>().getPhotos(limit, page);
  }

  void _onPhotosLoadingError() {
    state = state.copyWith(inProgress: false);
    showAlertDialog('Can\'t load photos',
        'There was an error while loading photos. Please try again later.');
  }
}
