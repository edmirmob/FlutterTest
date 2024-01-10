import 'package:flutter_test_1/core/models/comments.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_1/core/services/comments_service.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/models/posts.dart';
import '../../shared/content/content.dart';
import 'package:go_router/go_router.dart';

import 'models/post_id_route_data.dart';

class DashboardCard extends StatelessWidget {
  final String? title;
  final String? body;
  final String? name;
  final int? id;
  final List<Post>? posts;

  final bool loading;

  const DashboardCard({
    super.key,
    @required this.title,
    @required this.body,
    @required this.name,
    @required this.id,
    @required this.posts,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var isExpanded = BehaviorSubject<bool>.seeded(false);

    final commentsController = BehaviorSubject<List<Comments>>();
    return InkWell(
      onTap: () {
        PostIdRouteData postId = PostIdRouteData(id: id);
        context.goNamed('details', extra: postId);
      },
      child: Container(
        clipBehavior: Clip.none,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color:
                    const Color.fromARGB(255, 149, 149, 149).withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 10, right: 8.0),
          child: Content(
            loading: loading,
            child: StreamBuilder<bool>(
                stream: isExpanded.stream,
                builder: (context, expandedSnaphot) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title!,
                            maxLines: expandedSnaphot.data == false ? 2 : 10,
                            softWrap: true,
                            textAlign: TextAlign.left,
                            style: theme.textTheme.bodyLarge!.copyWith(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10.0,
                        ),
                        if (expandedSnaphot.data == true)
                          StreamBuilder<List<Comments>>(
                              stream: commentsController.stream,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container();
                                }
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                                snapshot.data![index].body!,
                                                textAlign: TextAlign.left,
                                                style: theme
                                                    .textTheme.bodyText1!
                                                    .copyWith(
                                                  fontSize: 15,
                                                )),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(name!,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: theme.textTheme.bodyText1!.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        InkWell(
                          onTap: () async {
                            isExpanded.add(!expandedSnaphot.data!);
                            context
                                .read<CommentsService>()
                                .getComments(id!)
                                .then((value) {
                              commentsController.add(value);
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  expandedSnaphot.data == false
                                      ? 'See more'
                                      : 'See less',
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: theme.textTheme.bodyText1!.copyWith(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue)),
                            ],
                          ),
                        ),
                      ]);
                }),
          ),
        ),
      ),
    );
  }
}
