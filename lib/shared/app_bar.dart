import 'package:flutter/material.dart';
import 'package:flutter_test_1/core/models/users.dart';
import 'package:flutter_test_1/providers/post/post_provider.dart';
import 'package:flutter_test_1/providers/post/post_state.dart';
import 'package:flutter_test_1/providers/user/user_state.dart';
import 'package:provider/provider.dart';
import 'logo_widget.dart';
import 'search_filed.dart';

class TestAppBar extends PreferredSize {
  final String? title;

  final bool showSearchBar;
  final String? textLeading;
  final Function? onPressedBack;

  const TestAppBar({
    super.key,
    this.title,
    this.textLeading,
    this.showSearchBar = true,
    this.onPressedBack,
    super.preferredSize = const Size.fromHeight(60),
    required super.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final postState = context.read<PostState>();

    return AppBar(
      backgroundColor: theme.appBarTheme.foregroundColor,
      toolbarHeight: 50,
      elevation: 1.5,
      leadingWidth: 50,
      leading: const Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: LogoWidget(),
      ),
      title: showSearchBar
          ? Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: SizedBox(
                width: 200,
                child: Selector<UserState, List<User>>(
                    selector: (_, state) => state.users,
                    builder: (_, stateUser, __) {
                      return SearchField(
                        onChanged: (String value) {
                          User usersId;

                          if (value.isNotEmpty) {
                            usersId = stateUser.firstWhere(
                                (tab) => tab.name!
                                    .toLowerCase()
                                    .contains(value.toLowerCase()), orElse: () {
                              usersId = User(
                                  id: 0, name: '', username: '', email: '');
                              return usersId;
                            });

                            context
                                .read<PostProvider>()
                                .searchPosts(usersId.id!, value);
                          } else {
                            context.read<PostProvider>().refreshPosts();
                          }
                        },
                        hint: 'Search',
                        initialValue: postState.search,
                      );
                    }),
              ),
            )
          : child,
      centerTitle: false,
      iconTheme: const IconThemeData(
        color: Color.fromARGB(255, 81, 142, 222),
      ),
      actionsIconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
