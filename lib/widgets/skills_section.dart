import 'package:flutter/material.dart';
import '../constants/colors.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Skills',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: [
              _buildSkillCard('Flutter', 0.9, Icons.flutter_dash),
              _buildSkillCard('Supabase', 0.85, Icons.star),
              _buildSkillCard('Python', 0.8, Icons.javascript),
              _buildSkillCard('Django', 0.95, Icons.code),
              _buildSkillCard('IT Support', 0.85, Icons.computer),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(String skill, double progress, IconData icon) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 1),
        duration: const Duration(milliseconds: 300),
        builder: (context, double scale, child) {
          return Transform.scale(
            scale: scale,
            child: Container(
              width: 160,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        icon,
                        color: AppColors.accent,
                        size: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        skill,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  AnimatedProgressBar(progress: progress),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AnimatedProgressBar extends StatelessWidget {
  final double progress;

  const AnimatedProgressBar({
    Key? key,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: progress),
      duration: const Duration(milliseconds: 1500),
      curve: Curves.easeOutCubic,
      builder: (context, double value, child) {
        return Stack(
          children: [
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.overlayColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            FractionallySizedBox(
              widthFactor: value,
              child: Container(
                height: 8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accent,
                      AppColors.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.5),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}