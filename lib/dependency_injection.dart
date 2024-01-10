import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

import 'core/repositories/photos_repository.dart';
import 'core/repositories/post_repository.dart';
import 'core/repositories/users_repository.dart';
import 'core/services/comments_service.dart';
import 'core/services/post_details_service.dart';
import 'providers/photos/photos_provider.dart';
import 'providers/photos/photos_state.dart';
import 'providers/post/post_provider.dart';
import 'providers/post/post_state.dart';
import 'providers/user/user_provider.dart';
import 'providers/user/user_state.dart';

List<SingleChildWidget> repositoryProviders = [
  Provider<PostRepository>(
    create: (_) => PostRepository(),
  ),
  Provider<UsersRepository>(
    create: (_) => UsersRepository(),
  ),
  Provider<PhotosRepository>(
    create: (_) => PhotosRepository(),
  ),
];

List<SingleChildWidget> serviceProviders = [
  Provider<CommentsService>(
    create: (_) => CommentsService(),
  ),
  Provider<PostDetailsService>(
    create: (_) => PostDetailsService(),
  ),
];

List<SingleChildWidget> stateNotifierProviders = [
  StateNotifierProvider<PostProvider, PostState>(
    create: (_) => PostProvider(),
  ),
  StateNotifierProvider<UserProvider, UserState>(
    create: (_) => UserProvider(),
  ),
  StateNotifierProvider<PhotosProvider, PhotosState>(
    create: (_) => PhotosProvider(),
  ),
];
