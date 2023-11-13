import 'package:flutter/material.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/dog_photo_splash.png',
          height: 64,width: 64,
          fit:BoxFit.fill),
      ),
    );
  }
}