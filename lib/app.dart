import 'package:flutter/material.dart';

import 'app_route_information_parser.dart';
import 'app_router_delegate.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final delegate = AppRouterDelegate();
    final routeInformationParser = AppRouteInformationParser();

    return MaterialApp.router(
        routeInformationParser: routeInformationParser,
        routerDelegate: delegate);
  }
}
