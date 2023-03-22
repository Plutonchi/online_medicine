import 'package:flutter/material.dart';
import 'package:online_medicine/app/screens/screen.dart';
import 'package:online_medicine/app/theme/theme.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: greenColor,
      ),
      home: const SplashScreen(),
    );
  }
}
