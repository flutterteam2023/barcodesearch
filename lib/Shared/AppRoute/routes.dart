import 'package:barcodesearch/Screens/home_screen.dart';
import 'package:barcodesearch/Screens/results_screen.dart';
import 'package:barcodesearch/Shared/AppRoute/error_screen.dart';
import 'package:barcodesearch/Shared/AppRoute/fake_login.dart';
import 'package:barcodesearch/Shared/AppRoute/fake_reset.dart';
import 'package:barcodesearch/Shared/AppRoute/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: "root navigotor key");
  // ignore: lines_longer_than_80_chars
  GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();
  GoRouter get router => GoRouter(
        navigatorKey: rootNavigatorKey,
        debugLogDiagnostics: true,
        errorBuilder: (context, state) => ErrorScreen(exception: state.error),
        initialLocation: APP_PAGE.initial.toPath,
        routes: [
          GoRoute(
            path: APP_PAGE.initial.toPath,
            name: APP_PAGE.initial.toName,
            builder: (BuildContext context, GoRouterState state) {
              return const HomeScreen();
            },
            routes: <RouteBase>[
              GoRoute(
                path: APP_PAGE.results.toPath,
                name: APP_PAGE.results.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return ResultScreen(
                    searchedText: state.queryParams["searchedText"] ?? "",
                  );
                },
              ),
              GoRoute(
                path: APP_PAGE.resetPassword.toPath,
                name: APP_PAGE.resetPassword.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const FakeReset();
                },
              ),
              GoRoute(
                path: APP_PAGE.login.toPath,
                name: APP_PAGE.login.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const FakeLogin();
                },
              ),
              GoRoute(
                path: APP_PAGE.register.toPath,
                name: APP_PAGE.register.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const SizedBox();
                },
              ),
            ],
          ),
        ],
      );
}
