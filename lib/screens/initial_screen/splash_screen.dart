import 'dart:async';

import 'package:flutter/material.dart';

import '../home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const HomeScreen())));
    });

    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: Colors.white,
            child: Center(
              child: Image.asset(
                'assets/splash_logo.png',
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.7,
              ),
            )),
          )
    );
  }
}
