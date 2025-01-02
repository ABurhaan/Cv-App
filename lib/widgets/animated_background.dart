import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../constants/colors.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  final List<ParticleModel> particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    // Initialize particles
    for (int i = 0; i < 50; i++) {
      particles.add(ParticleModel.random());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size.infinite,
          painter: BackgroundPainter(
            animationValue: _controller.value,
            particles: particles,
          ),
        );
      },
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double animationValue;
  final List<ParticleModel> particles;

  BackgroundPainter({
    required this.animationValue,
    required this.particles,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw gradient background
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.gradientStart,
          AppColors.gradientEnd,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      paint,
    );

    // Draw particles
    for (var particle in particles) {
      final position = particle.getPosition(animationValue, size);
      final paint = Paint()
        ..color = AppColors.accent.withOpacity(0.2)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(BackgroundPainter oldDelegate) => 
    oldDelegate.animationValue != animationValue;
}

class ParticleModel {
  final double speed;
  final double theta;
  final double radius;
  final double size;

  ParticleModel({
    required this.speed,
    required this.theta,
    required this.radius,
    required this.size,
  });

  factory ParticleModel.random() {
    return ParticleModel(
      speed: math.Random().nextDouble() * 2 + 0.5,
      theta: math.Random().nextDouble() * 2 * math.pi,
      radius: math.Random().nextDouble() * 100 + 50,
      size: math.Random().nextDouble() * 3 + 1,
    );
  }

  Offset getPosition(double animation, Size size) {
    final progress = (animation * speed) % 1.0;
    final angle = theta + 2 * math.pi * progress;
    final x = size.width / 2 + radius * math.cos(angle);
    final y = size.height / 2 + radius * math.sin(angle);
    return Offset(x, y);
  }
}