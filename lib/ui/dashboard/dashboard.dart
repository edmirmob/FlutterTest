// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_test_1/core/models/posts.dart';
import 'package:flutter_test_1/core/models/users.dart';
import 'package:flutter_test_1/ui/dashboard/dashboard_card.dart';
import 'package:flutter_test_1/providers/post/post_provider.dart';
import 'package:flutter_test_1/providers/post/post_state.dart';
import 'package:flutter_test_1/providers/user/user_provider.dart';
import 'package:flutter_test_1/providers/user/user_state.dart';
import 'package:tuple/tuple.dart';
import 'package:provider/provider.dart';
import '../../shared/app_bar.dart';
import '../../shared/drawer.dart';
import '../../shared/no_data.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) {
      final userProvider = context.read<UserProvider>();
      userProvider.loadUsers();

      final postProvider = context.read<PostProvider>();
      postProvider.loadPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: const TestAppBar(
          child: SizedBox(),
        ),
        endDrawer: const SizedBox(width: 200, child: DrawerWidget()),
        body: CustomScrollView(
          slivers: [
            Selector2<PostState, UserState, Tuple2<bool, bool>>(
              selector: (_, state, userState) =>
                  Tuple2(state.loadingFirstPage, userState.loadingFirstPage),
              builder: (_, loadingFirstPage, __) {
                if (loadingFirstPage.item1 && loadingFirstPage.item2) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, index) {
                        return const DashboardCard(
                          id: 0,
                          name: 'Name',
                          title: 'Title',
                          body: 'Body',
                          posts: [],
                          loading: true,
                        );
                      },
                      childCount: 40,
                    ),
                  );
                }

                return const SliverToBoxAdapter();
              },
            ),
            Selector2<PostState, UserState, Tuple2<List<Post>, List<User>>>(
                selector: (_, postState, userState) => Tuple2(
                      postState.posts,
                      userState.users,
                    ),
                builder: (_, state, __) {
                  if (state.item1.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: NoData(),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.only(bottom: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, index) {
                          final post = state.item1[index];

                          final name = (state.item2
                              .firstWhere((e) => e.id == post.userId)
                              .name);

                          return DashboardCard(
                            id: post.id,
                            name: name,
                            body: post.body,
                            title: post.title,
                            posts: state.item1,
                          );
                        },
                        childCount: state.item1.length,
                      ),
                    ),
                  );
                })
          ],
        ));
  }
}
