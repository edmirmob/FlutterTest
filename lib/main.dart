import 'package:flutter/material.dart';
import 'package:flutter_test_1/ui/post_details/post_details.dart';

import 'common/current_context.dart';
import 'ui/dashboard/dashboard.dart';
import 'dependency_injection.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'ui/dashboard/models/post_id_route_data.dart';
import 'ui/photos/photos.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ...repositoryProviders,
      ...serviceProviders,
      ...stateNotifierProviders,
    ], child: const MyApp()),
  );
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          name: 'details',
          builder: (BuildContext context, GoRouterState state) {
            PostIdRouteData postId = state.extra as PostIdRouteData;
            return PostDetailsPage(
              postIdRouteData: postId,
            );
          },
        ),
        GoRoute(
          path: 'photos',
          builder: (BuildContext context, GoRouterState state) {
            return const PhotoPage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryTextTheme: const TextTheme(
          bodyLarge: TextStyle(
              color: Color(0xff212131),
              fontSize: 22,
              fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(
              color: Color(0xff595756),
              fontSize: 16,
              fontWeight: FontWeight.w600),
        ),
        hintColor: const Color(0xff363030),
        primaryIconTheme: const IconThemeData(color: Color(0xffF25C42)),
        iconTheme: const IconThemeData(color: Color(0xff8B8B8B), size: 18),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xff4747B6)),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'OpenSans',
        cardColor: const Color(0xffFFDBD1),
        cardTheme: const CardTheme(
          color: Color(0xffE2F1FC),
        ),
        appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0,
            actionsIconTheme: IconThemeData(
              color: Color(0xff4747B5),
            ),
            foregroundColor: Color(0xff873e23)),
      ),
    );
  }
}
