import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'countdown_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _textController;
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();

    // Text animation controller
    _textController = AnimationController(
      duration: Duration(seconds: 20),
      vsync: this,
    );

    // Lottie animation controller
    _lottieController = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );

    _textController.forward();
    _lottieController.forward();

    Future.delayed(Duration(seconds: 20), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => NewYearAnimation(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Text Content
          Center(
            child: FadeTransition(
              opacity: _textController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Happy New Year',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 36,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '2025',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 72,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Lottie Animation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Lottie.asset(
              'assets/images/anim.json', // Replace with your Lottie file name
              controller: _lottieController,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4, // Takes bottom 40% of screen
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
        ],
      ),
    );
  }
}