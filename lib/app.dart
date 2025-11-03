import 'package:flutter/material.dart';
import 'package:handcrafts/screens/onboardingscreens/onboarding_first.dart';
import 'package:handcrafts/screens/product_screen.dart';

class HandicraftsApp extends StatelessWidget {
  const HandicraftsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handicrafts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const OnboardingFirstScreen(),
    );
  }
}
