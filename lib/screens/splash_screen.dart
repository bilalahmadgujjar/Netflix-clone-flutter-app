import 'dart:async';
import 'package:corona/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => BottomNavBar()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Lottie.asset("assets/netflix.json"),
      ),
    );
  }
}
