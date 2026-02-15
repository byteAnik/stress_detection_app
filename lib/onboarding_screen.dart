// onboarding_screen.dart
// Complete Onboarding Flow with 3 screens

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  Future<void> _skipOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete', true);
    
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/signup');
    }
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _skipOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _skipOnboarding,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF666666),
                    ),
                  ),
                ),
              ),
            ),

            // PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: const [
                  OnboardingPage1(),
                  OnboardingPage2(),
                  OnboardingPage3(),
                ],
              ),
            ),

            // Progress Dots
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? const Color(0xFF4ECDC4)
                          : const Color(0xFFE9ECEF),
                    ),
                  );
                }),
              ),
            ),

            // Next / Get Started Button
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 40),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4ECDC4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    _currentPage == 2 ? 'Get Started' : 'Next',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================
// ONBOARDING PAGE 1: Mental Health
// ============================================

class OnboardingPage1 extends StatefulWidget {
  const OnboardingPage1({Key? key}) : super(key: key);

  @override
  State<OnboardingPage1> createState() => _OnboardingPage1State();
}

class _OnboardingPage1State extends State<OnboardingPage1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        
        // Illustration Container
        Container(
          width: 275,
          height: 275,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F9FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  size: const Size(200, 200),
                  painter: BrainIllustrationPainter(
                    animationValue: _controller.value,
                  ),
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 50),

        // Title
        const Text(
          'Understand Your',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'Mental Health',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 30),

        // Description
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Track your stress levels using AI-powered analysis of your daily interactions and behavioral patterns.',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// Custom Painter for Brain Illustration
class BrainIllustrationPainter extends CustomPainter {
  final double animationValue;

  BrainIllustrationPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);

    // Glow circle (animated)
    paint.color = const Color(0xFFA7C7E7).withOpacity(0.3 * animationValue);
    canvas.drawCircle(center, 80, paint);

    // Brain shape (simplified)
    paint.color = const Color(0xFFFFB6C1).withOpacity(0.8);
    
    // Main brain ellipse
    canvas.drawOval(
      Rect.fromCenter(center: center, width: 100, height: 110),
      paint,
    );

    // Left hemisphere
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx - 15, center.dy - 5),
        width: 50,
        height: 60,
      ),
      paint,
    );

    // Right hemisphere
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(center.dx + 15, center.dy - 5),
        width: 50,
        height: 60,
      ),
      paint,
    );

    // EKG line (animated)
    final linePaint = Paint()
      ..color = const Color(0xFF4ECDC4)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final startY = center.dy + 60;
    path.moveTo(center.dx - 60, startY);
    path.lineTo(center.dx - 30, startY);
    path.lineTo(center.dx - 20, startY - 20 * animationValue);
    path.lineTo(center.dx - 10, startY + 25 * animationValue);
    path.lineTo(center.dx, startY - 15 * animationValue);
    path.lineTo(center.dx + 10, startY);
    path.lineTo(center.dx + 60, startY);

    canvas.drawPath(path, linePaint);

    // AI chip
    final chipRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy - 60),
      width: 24,
      height: 24,
    );
    paint.color = const Color(0xFF667eea);
    canvas.drawRRect(
      RRect.fromRectAndRadius(chipRect, const Radius.circular(4)),
      paint,
    );

    // Pulse dots
    paint.color = const Color(0xFF4ECDC4).withOpacity(animationValue);
    canvas.drawCircle(
      Offset(center.dx - 50, center.dy - 35),
      5 + (3 * animationValue),
      paint,
    );
    canvas.drawCircle(
      Offset(center.dx + 50, center.dy - 35),
      5 + (3 * animationValue),
      paint,
    );
  }

  @override
  bool shouldRepaint(BrainIllustrationPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}

// ============================================
// ONBOARDING PAGE 2: Privacy
// ============================================

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        
        // Illustration Container
        Container(
          width: 275,
          height: 275,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FFF4),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: CustomPaint(
              size: const Size(200, 200),
              painter: PrivacyShieldPainter(),
            ),
          ),
        ),

        const SizedBox(height: 50),

        // Title
        const Text(
          'Your Privacy',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'Comes First',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 30),

        // Description
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'All AI processing happens on your device. No data is sent to the cloud. Your mental health information stays 100% private.',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// Custom Painter for Privacy Shield
class PrivacyShieldPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.fill;

    // Shield shape
    final shieldPath = Path();
    shieldPath.moveTo(center.dx, center.dy - 60);
    shieldPath.lineTo(center.dx + 45, center.dy - 45);
    shieldPath.lineTo(center.dx + 45, center.dy);
    shieldPath.quadraticBezierTo(
      center.dx + 45, center.dy + 40,
      center.dx, center.dy + 60,
    );
    shieldPath.quadraticBezierTo(
      center.dx - 45, center.dy + 40,
      center.dx - 45, center.dy,
    );
    shieldPath.lineTo(center.dx - 45, center.dy - 45);
    shieldPath.close();

    // Shield gradient
    paint.shader = LinearGradient(
      colors: [
        const Color(0xFF4ECDC4).withOpacity(0.9),
        const Color(0xFFB7E4C7).withOpacity(0.8),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromCircle(center: center, radius: 80));

    canvas.drawPath(shieldPath, paint);

    // Lock icon
    paint.shader = null;
    paint.color = const Color(0xFF667eea);
    
    // Lock body
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: center, width: 30, height: 25),
        const Radius.circular(4),
      ),
      paint,
    );

    // Lock shackle
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 5;
    paint.strokeCap = StrokeCap.round;
    
    final shacklePath = Path();
    shacklePath.moveTo(center.dx - 10, center.dy - 5);
    shacklePath.quadraticBezierTo(
      center.dx - 10, center.dy - 15,
      center.dx, center.dy - 15,
    );
    shacklePath.quadraticBezierTo(
      center.dx + 10, center.dy - 15,
      center.dx + 10, center.dy - 5,
    );
    canvas.drawPath(shacklePath, paint);

    // Checkmarks
    paint.style = PaintingStyle.fill;
    paint.color = const Color(0xFFB7E4C7);
    
    final checkPositions = [
      Offset(center.dx - 55, center.dy - 30),
      Offset(center.dx + 55, center.dy - 30),
      Offset(center.dx - 55, center.dy + 30),
      Offset(center.dx + 55, center.dy + 30),
    ];

    for (var pos in checkPositions) {
      canvas.drawCircle(pos, 14, paint);
      
      // Check mark
      paint.color = Colors.white;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 2.5;
      
      final checkPath = Path();
      checkPath.moveTo(pos.dx - 5, pos.dy);
      checkPath.lineTo(pos.dx - 1, pos.dy + 4);
      checkPath.lineTo(pos.dx + 5, pos.dy - 4);
      canvas.drawPath(checkPath, paint);
      
      paint.style = PaintingStyle.fill;
      paint.color = const Color(0xFFB7E4C7);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================
// ONBOARDING PAGE 3: Support
// ============================================

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        
        // Illustration Container
        Container(
          width: 275,
          height: 275,
          margin: const EdgeInsets.symmetric(horizontal: 50),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF4E6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: CustomPaint(
              size: const Size(200, 200),
              painter: SupportIllustrationPainter(),
            ),
          ),
        ),

        const SizedBox(height: 50),

        // Title
        const Text(
          '24/7 Support',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'When You Need It',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 30),

        // Description
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Access professional help, crisis hotlines, and instant stress relief exercises whenever you need them. You\'re never alone.',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF666666),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// Custom Painter for Support Illustration
class SupportIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..style = PaintingStyle.fill;

    // Central support circle
    paint.shader = LinearGradient(
      colors: [
        const Color(0xFFFF9B9B),
        const Color(0xFFFFD93D),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(Rect.fromCircle(center: center, radius: 50));

    canvas.drawCircle(center, 50, paint);

    // Headset icon
    paint.shader = null;
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    paint.strokeCap = StrokeCap.round;

    // Headband
    final headbandPath = Path();
    headbandPath.moveTo(center.dx - 20, center.dy - 20);
    headbandPath.quadraticBezierTo(
      center.dx, center.dy - 30,
      center.dx + 20, center.dy - 20,
    );
    canvas.drawPath(headbandPath, paint);

    // Earpieces
    paint.style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx - 20, center.dy - 12),
          width: 8,
          height: 15,
        ),
        const Radius.circular(4),
      ),
      paint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx + 20, center.dy - 12),
          width: 8,
          height: 15,
        ),
        const Radius.circular(4),
      ),
      paint,
    );

    // 24/7 text
    final textPainter = TextPainter(
      text: const TextSpan(
        text: '24/7',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(center.dx - textPainter.width / 2, center.dy + 10),
    );

    // Helper people around (simplified circles)
    final peoplePositions = [
      Offset(center.dx, center.dy - 75),
      Offset(center.dx - 70, center.dy - 20),
      Offset(center.dx + 70, center.dy - 20),
      Offset(center.dx - 50, center.dy + 60),
      Offset(center.dx + 50, center.dy + 60),
    ];

    final colors = [
      const Color(0xFFB7E4C7),
      const Color(0xFFA7C7E7),
      const Color(0xFFFFE66D),
      const Color(0xFF4ECDC4),
      const Color(0xFFFF9B9B),
    ];

    paint.style = PaintingStyle.fill;
    for (int i = 0; i < peoplePositions.length; i++) {
      paint.color = colors[i];
      canvas.drawCircle(peoplePositions[i], 18, paint);
      
      // Simple face
      paint.color = Colors.white;
      canvas.drawCircle(
        Offset(peoplePositions[i].dx, peoplePositions[i].dy - 5),
        8,
        paint,
      );
      
      // Smile
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 3;
      final smilePath = Path();
      smilePath.moveTo(peoplePositions[i].dx - 8, peoplePositions[i].dy + 8);
      smilePath.lineTo(peoplePositions[i].dx + 8, peoplePositions[i].dy + 8);
      canvas.drawPath(smilePath, paint);
      
      paint.style = PaintingStyle.fill;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}