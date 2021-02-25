import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: App()));
}

class PrepareApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.hasError) {
          return Container(); // TODO: Add Error widget
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return App();
        }

        return Container(); // TODO: Add Error widget
      },
    );
  }
}
