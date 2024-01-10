import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test_1/core/models/photos.dart';
import 'package:flutter_test_1/providers/photos/photos_provider.dart';
import 'package:flutter_test_1/providers/photos/photos_state.dart';
import 'package:flutter_test_1/shared/app_bar.dart';
import 'package:provider/provider.dart';

import '../../shared/drawer.dart';
import '../../shared/no_data.dart';

import 'photo_card.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      final photosProvider = context.read<PhotosProvider>();

      photosProvider.loadPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final gamesBookmarksProvider = context.read<PhotosProvider>();

    return Scaffold(
      appBar: const TestAppBar(
        showSearchBar: false,
        child: Text('Photos'),
      ),
      endDrawer: const SizedBox(
        width: 200,
        child: DrawerWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: NotificationListener<ScrollNotification>(
          onNotification: (sn) {
            if (sn.metrics.pixels + 300 >= sn.metrics.maxScrollExtent) {
              gamesBookmarksProvider.loadMorePhotos();
            }
            return true;
          },
          child: CustomScrollView(
            slivers: [
              Selector<PhotosState, bool>(
                selector: (_, state) => state.loadingFirstPage,
                builder: (_, loadingFirstPage, __) {
                  if (loadingFirstPage) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, index) {
                          return const PhotoCard(
                            url: 'Url',
                            loading: true,
                          );
                        },
                        childCount: 10,
                      ),
                    );
                  }

                  return const SliverToBoxAdapter();
                },
              ),
              Selector<PhotosState, List<Photos>>(
                  selector: (_, state) => state.photos,
                  builder: (_, photos, __) {
                    if (photos.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: NoData(),
                      );
                    }

                    return SliverPadding(
                      padding: const EdgeInsets.only(bottom: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, index) {
                            final photo = photos[index];
                            return PhotoCard(
                              url: photo.url,
                            );
                          },
                          childCount: photos.length,
                        ),
                      ),
                    );
                  }),
              Selector<PhotosState, bool>(
                selector: (_, state) => state.loadingMoreData,
                builder: (_, loadingMoreData, __) {
                  if (loadingMoreData) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, index) {
                          return const Padding(
                            padding: EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: PhotoCard(
                              url: 'Url',
                              loading: true,
                            ),
                          );
                        },
                        childCount: 1,
                      ),
                    );
                  }

                  return const SliverToBoxAdapter();
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: 160,
        height: 50,
        child: TextField(
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          decoration: const InputDecoration(
            labelText: 'Limit',
            hintText: 'example: 10',
            filled: true,
            fillColor: Color(0xFFF2F2F2),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(width: 1, color: Colors.black),
            ),
            errorBorder: InputBorder.none,
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              int limit = int.parse(value);

              context.read<PhotosProvider>().filterPhoto(
                    limit,
                  );
            }
          },
        ),
      ),
    );
  }
}
