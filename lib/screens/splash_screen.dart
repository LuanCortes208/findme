import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _fadeController.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade600, Colors.blue.shade900],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const _AnimatedIcon(),
                const SizedBox(height: 24),
                const Text(
                  'Find Me',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Achados e Perdidos Universitário',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                 const SizedBox(height: 48),
                const _PulsingDots(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedIcon extends StatefulWidget {
  const _AnimatedIcon();

  @override
  __AnimatedIconState createState() => __AnimatedIconState();
}

class __AnimatedIconState extends State<_AnimatedIcon> with TickerProviderStateMixin {
  late AnimationController _pingController;

  @override
  void initState() {
    super.initState();
    _pingController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pingController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FadeTransition(
          opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_pingController),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.5).animate(_pingController),
            child: Icon(Icons.inventory_2_outlined, size: 80, color: Colors.white.withOpacity(0.3)),
          ),
        ),
        const Icon(Icons.inventory_2_outlined, size: 80, color: Colors.white),
      ],
    );
  }
}

// Widget auxiliar para os pontos pulsantes
class _PulsingDots extends StatefulWidget {
  const _PulsingDots();
  
  @override
  __PulsingDotsState createState() => __PulsingDotsState();
}

class __PulsingDotsState extends State<_PulsingDots> with TickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return FadeTransition(
          opacity: _pulseController.drive(
            CurveTween(curve: Interval(index * 0.2, (index + 1) * 0.33, curve: Curves.easeInOut)),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: CircleAvatar(radius: 4, backgroundColor: Colors.white),
          ),
        );
      }),
    );
  }
}