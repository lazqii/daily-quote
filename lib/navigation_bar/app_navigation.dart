import 'package:daily_quote/home/home_view.dart';
import 'package:daily_quote/wrapper/main_wrapper.dart';
import 'package:daily_quote/bookmark/bookmark.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();
  static String initR = '/home';

  /// Private Navigators Keys
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _rootNavigatorHome = GlobalKey<NavigatorState>(
    debugLabel: 'shelhome',
  );
  static final _rootNavigatorSetting = GlobalKey<NavigatorState>(
    debugLabel: 'shelbookmark',
  );

  /// Go Router Configuration

  static final GoRouter router = GoRouter(
    initialLocation: initR,
    navigatorKey: _rootNavigatorKey,
    routes: <RouteBase>[
      /// MainWrapper Router
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _rootNavigatorHome,
            routes: [
              GoRoute(
                path: '/home',
                name: 'Home',
                builder: (context, state) {
                  return HomePage(key: state.pageKey);
                },
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _rootNavigatorSetting,
            routes: [
              GoRoute(
                path: '/bookmark',
                name: 'Bookmark',
                builder: (context, state) {
                  return BookmarkPage(key: state.pageKey);
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
