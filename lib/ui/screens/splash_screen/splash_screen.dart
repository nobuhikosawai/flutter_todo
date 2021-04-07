import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SizedBox(
                height: MediaQuery.of(context).size.width * 0.785,
                width: MediaQuery.of(context).size.width * 0.785,
                child: Image.asset('assets/icon/logo.png'))));
  }
}
