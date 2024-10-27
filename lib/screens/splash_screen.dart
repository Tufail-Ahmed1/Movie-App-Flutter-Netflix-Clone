import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie_app/widgets/bottom_nav_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4),
            () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const BottomNavBar(),));
            }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child:Lottie.asset("assets/netflix_lottie.json"),

    );
  }
}
