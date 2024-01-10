import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../shared/content/content.dart';

class PhotoCard extends StatelessWidget {
  final String? url;

  final bool? loading;

  const PhotoCard({
    super.key,
    @required this.url,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: 400,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Content(
                  loading: loading!,
                  child: CachedNetworkImage(
                    imageUrl: url!,
                    placeholder: (context, url) => Content(
                      loading: true,
                      child: const SizedBox(
                        height: 350,
                        width: 400,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
