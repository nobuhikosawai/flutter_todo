import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app_route_information_parser.dart';
import 'app_router_delegate.dart';
import 'ui/controllers/me_controller.dart';

class App extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final me = useProvider(meProvider.state);

    final delegate = AppRouterDelegate(me: me);
    final routeInformationParser = AppRouteInformationParser();

    return MaterialApp.router(
        routeInformationParser: routeInformationParser,
        routerDelegate: delegate);
  }
}
