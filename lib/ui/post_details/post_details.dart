// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_test_1/core/models/posts.dart';

import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/services/post_details_service.dart';

import '../dashboard/models/post_id_route_data.dart';
import 'package:go_router/go_router.dart';

class PostDetailsPage extends StatefulWidget {
  final PostIdRouteData? postIdRouteData;

  const PostDetailsPage({@required this.postIdRouteData, super.key});
  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final postDetailsController = BehaviorSubject<Post>();
  @override
  void initState() {
    super.initState();

    context
        .read<PostDetailsService>()
        .getPostDetails(widget.postIdRouteData!.id!)
        .then((value) => postDetailsController.add(value));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.go('/'),
        ),
        title: const Text("Post Details"),
        centerTitle: true,
      ),
      body: StreamBuilder<Post>(
          stream: postDetailsController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(snapshot.data!.title!,
                      style: theme.textTheme.bodyLarge!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(snapshot.data!.body!,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontSize: 15,
                      )),
                ],
              ),
            );
          }),
    );
  }
}
