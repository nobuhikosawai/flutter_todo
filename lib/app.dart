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
        theme: ThemeData(
            scaffoldBackgroundColor: Color.fromRGBO(255, 255, 255, 0.95),
            primaryColor: Color.fromRGBO(0, 126, 250, 1.0),
            accentColor: Color.fromRGBO(243, 48, 250, 1.0),
            textTheme: TextTheme(
              headline1: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.black87),
              headline2: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  color: Colors.black87),
              bodyText1:
                  TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
            )),
        routeInformationParser: routeInformationParser,
        routerDelegate: delegate);
  }
}
