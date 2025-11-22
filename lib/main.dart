import 'package:flutter/material.dart';
import 'package:naibrly/utils/app_contants.dart';
import 'package:naibrly/views/screen/welcome/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: AppConstants.FONTFAMILY,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      builder: (context, child) => SafeArea(
        top: false,
        left: false,
        right: false,
        bottom: true,
        child: child ?? const SizedBox.shrink(),
      ),
      home: WelcomeScreen(),
    );
  }
}


