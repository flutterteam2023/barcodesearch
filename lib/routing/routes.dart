import 'package:barcodesearch/features/Searching/home_screen.dart';
import 'package:barcodesearch/features/Searching/results_screen.dart';
import 'package:barcodesearch/features/Onboarding/onboarding_screen.dart';
import 'package:barcodesearch/routing/error_screen.dart';

import 'package:barcodesearch/routing/route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
              bool isFirstAppOpen = false;
              if (isFirstAppOpen) {
                return OnboardingScreen();
              } else {
                return StreamBuilder(
                  stream: FirebaseAuth.instance.userChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return const HomeScreen();
                    } else {
                      return const HomeScreen();
                    }
                  },
                );
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
