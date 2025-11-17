import 'package:flutter/material.dart';

import '../authentication/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    // Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _animation = Tween<Offset>(
      begin: const Offset(0, 2.5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _controller.forward();

    // Navigate after delay
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F9), // same grey background
      body: Center(
        child: SlideTransition(
          position: _animation,
          child: Text(
            "DROVVI",
            style: TextStyle(
              color: Color(0xff10CFCF),
              fontSize: 48,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
        ),
      ),
    );
  }
}
