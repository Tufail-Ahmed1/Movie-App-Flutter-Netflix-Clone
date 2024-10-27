import 'package:flutter/material.dart';
import 'package:movie_app/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white,fontSize: 24),
          bodyMedium: TextStyle(color: Colors.white,fontSize: 20),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple).copyWith(
          surface: Colors.black,

        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
