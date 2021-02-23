import 'package:flutter/material.dart';

import 'app_router_configuration.dart';
import 'ui/screens/todo_screen/todo_screen.dart';

class AppRouterDelegate extends RouterDelegate<AppRouterConfiguration>
    with
        ChangeNotifier,
        PopNavigatorRouterDelegateMixin<AppRouterConfiguration> {
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
    _pages = [MaterialPage<void>(key: ValueKey('home'), child: TodoScreen())];
    return Navigator(
      key: navigatorKey,
      pages: _pages,
      onPopPage: _handlePop,
    );
  }
}
