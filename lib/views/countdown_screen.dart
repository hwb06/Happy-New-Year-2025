import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:confetti/confetti.dart';

class NewYearAnimation extends StatefulWidget {
  @override
  _NewYearAnimationState createState() => _NewYearAnimationState();
}

class _NewYearAnimationState extends State<NewYearAnimation> with TickerProviderStateMixin {
  late AnimationController _balloonController;
  late AnimationController _numberController;
  late AnimationController _transitionController;
  late AnimationController _textController;
  late Animation<double> _balloonAnimation;
  late Animation<Offset> _numberSlideAnimation;
  late ConfettiController _confettiController;
  bool _isPlaying = false;
  bool _showNewScreen = false;

  @override
  void initState() {
    super.initState();

    _balloonController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _balloonAnimation = Tween<double>(
      begin: 0.0,
      end: -2.0,
    ).animate(CurvedAnimation(
      parent: _balloonController,
      curve: Curves.easeOut,
    ));

    _numberController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _numberSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _numberController,
      curve: Curves.easeInOut,
    ));

    _transitionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Initialize confetti controller with longer duration
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );

    _textController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _balloonController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _showTransitionScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Stack(
              children: [
                // Base "202" text
                Positioned(
                  top: screenSize.height * 0.40,
                  left: screenSize.width * 0.25,
                  child: Row(
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            colors: [Colors.blue, Colors.white],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds);
                        },
                        child: Text(
                          '202',
                          style: TextStyle(
                            fontSize: 80,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Balloon and "4" animation
                Positioned(
                  top: screenSize.height * 0.3,
                  left: screenSize.width * 0.47,
                  child: AnimatedBuilder(
                    animation: _balloonAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, screenSize.height * _balloonAnimation.value),
                        child: Opacity(
                          opacity: _isPlaying ? (1 - _balloonController.value) : 1.0,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 100,
                                child: Lottie.asset(
                                  'assets/images/baloonanim.json',
                                  controller: _balloonController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // Sliding "5" animation
                Positioned(
                  top: screenSize.height * 0.40,
                  left: screenSize.width * 0.58,
                  child: SlideTransition(
                    position: _numberSlideAnimation,
                    child: ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: [Colors.blue, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      child: Text(
                        '5',
                        style: TextStyle(
                          fontSize: 80,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // New Year Celebration Screen with Multiple Confetti Sources
          if (_showNewScreen)
            FadeTransition(
              opacity: _transitionController,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Stack(
                  children: [
                    // Left confetti source
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirection: 0, // Shoots right
                        emissionFrequency: 0.05,
                        numberOfParticles: 20,
                        maxBlastForce: 5,
                        minBlastForce: 2,
                        gravity: 0.1,
                        colors: const [
                          Colors.blue,
                          Colors.pink,
                          Colors.green,
                          Colors.orange,
                          Colors.purple,
                        ],
                      ),
                    ),

                    // Right confetti source
                    Align(
                      alignment: Alignment.centerRight,
                      child: ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirection: pi, // Shoots left
                        emissionFrequency: 0.05,
                        numberOfParticles: 20,
                        maxBlastForce: 5,
                        minBlastForce: 2,
                        gravity: 0.1,
                        colors: const [
                          Colors.blue,
                          Colors.pink,
                          Colors.green,
                          Colors.orange,
                          Colors.purple,
                        ],
                      ),
                    ),

                    // Top center confetti source
                    Align(
                      alignment: Alignment.topCenter,
                      child: ConfettiWidget(
                        confettiController: _confettiController,
                        blastDirection: pi / 2,
                        emissionFrequency: 0.05,
                        numberOfParticles: 30,
                        maxBlastForce: 5,
                        minBlastForce: 2,
                        gravity: 0.1,
                        colors: const [
                          Colors.blue,
                          Colors.pink,
                          Colors.green,
                          Colors.orange,
                          Colors.purple,
                        ],
                      ),
                    ),

                    Center(
                      child: FadeTransition(
                        opacity: _textController,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) {
                                return LinearGradient(
                                  colors: [
                                    Colors.blue.withOpacity(0.8),
                                    Colors.white.withOpacity(0.8),
                                    Colors.orange.withOpacity(0.8)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds);
                              },
                              child: Text(
                                'Happy New Year',
                                style: TextStyle(
                                  fontSize: 45,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 10.0,
                                      color: Colors.black.withOpacity(0.5),
                                      offset: Offset(4.0, 4.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ShaderMask(
                              shaderCallback: (bounds) {
                                return LinearGradient(
                                  colors: [Color(0xFF00C6FB), Color(0xFF005BEA)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds);
                              },
                              child: Text(
                                '2025',
                                style: TextStyle(
                                  fontSize: 78,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Play Button
          if (!_showNewScreen)
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  onTap: _startAnimation,
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.8),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showTransitionScreen() {
    setState(() => _showNewScreen = true);
    _transitionController.forward();
    Future.delayed(Duration(milliseconds: 200), () {
      _confettiController.play();
    });
    _textController.forward();
  }

  void _startAnimation() {
    if (!_isPlaying) {
      setState(() => _isPlaying = true);
      _balloonController.forward();
      _numberController.forward();
    }
  }

  @override
  void dispose() {
    _balloonController.dispose();
    _numberController.dispose();
    _transitionController.dispose();
    _textController.dispose();
    _confettiController.dispose();
    super.dispose();
  }
}