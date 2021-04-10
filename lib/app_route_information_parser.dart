import 'package:flutter/material.dart';

import 'app_router_configuration.dart';

class AppRouteInformationParser extends RouteInformationParser<AppRouterConfiguration> {
  @override
  Future<AppRouterConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final routeName = routeInformation.location;
    if (routeName == '/') return AppRouterConfiguration.home;
    throw 'unknown';
  }

  @override
  RouteInformation restoreRouteInformation(configuration) {
    switch (configuration) {
      case AppRouterConfiguration.home:
        return const RouteInformation(location: '/');
    }
  }
}
