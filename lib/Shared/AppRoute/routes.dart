import 'package:barcodesearch/Screens/home_screen.dart';
import 'package:barcodesearch/Screens/onboardingScreen/dart/onboarding_Screen.dart';
import 'package:barcodesearch/Screens/results_screen.dart';
import 'package:barcodesearch/Shared/AppRoute/error_screen.dart';

import 'package:barcodesearch/Shared/AppRoute/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root navigotor key');
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
              bool isFirstAppOpen = true;
              if (isFirstAppOpen) {
                return OnboardingScreen();
              } else {
                return HomeScreen();
              }
            },
            routes: <RouteBase>[
              GoRoute(
                path: APP_PAGE.onboarding.toPath,
                name: APP_PAGE.onboarding.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return OnboardingScreen();
                },
              ),
              GoRoute(
                path: APP_PAGE.results.toPath,
                name: APP_PAGE.results.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return ResultScreen(
                    searchedText: state.queryParams['searchedText'] ?? '',
                  );
                },
              ),
              GoRoute(
                path: APP_PAGE.home.toPath,
                name: APP_PAGE.home.toName,
                builder: (BuildContext context, GoRouterState state) {
                  return const HomeScreen();
                },
              ),
            ],
          ),
        ],
      );
}
