import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_router_configuration.dart';
import 'data/entities/me.dart';
import 'ui/screens/sign_in_screen/sign_in_screen.dart';
import 'ui/screens/splash_screen/splash_screen.dart';
import 'ui/screens/todo_screen/todo_screen.dart';

class AppRouterDelegate extends RouterDelegate<AppRouterConfiguration>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<AppRouterConfiguration> {
  AppRouterDelegate({@required this.me});

  AsyncValue<Me> me;

  AppRouterConfiguration _configuration;

  AppRouterConfiguration get configuration => _configuration;

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  set configuration(AppRouterConfiguration value) {
    if (_configuration == value) return;
    _configuration = value;
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(AppRouterConfiguration configuration) async {
    _configuration = configuration;
  }

  bool _handlePop(Route<dynamic> route, dynamic result) {
    final success = route.didPop(result);
    if (success) {
      _configuration = AppRouterConfiguration.home;
      notifyListeners();
    }
    return success;
  }

  @override
  Widget build(BuildContext context) {
    var _pages = <Page>[];
    me.when(
      data: (value) => _pages = (value == null)
          ? [
              MaterialPage<void>(
                  key: ValueKey('sign_in'), child: SignInScreen()),
            ]
          : [
              MaterialPage<void>(key: ValueKey('home'), child: TodoScreen()),
            ],
      loading: () => _pages = [
        MaterialPage<void>(key: ValueKey('splash'), child: SplashScreen()),
      ],
      error: (error, stack) => _pages = [
        MaterialPage<void>(key: ValueKey('unknown'), child: Container())
      ],
    );

    return Navigator(
      key: navigatorKey,
      pages: _pages,
      onPopPage: _handlePop,
    );
  }
}
