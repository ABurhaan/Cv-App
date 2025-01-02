import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/colors.dart';
import 'animated_text.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({Key? key}) : super(key: key);
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Image with Animated Border
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: 1),
              duration: const Duration(seconds: 1),
              builder: (context, double value, child) {
                return Transform.scale(
                  scale: value,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: SweepGradient(
                        colors: [
                          AppColors.accent,
                          AppColors.secondary,
                          AppColors.accent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                        transform: GradientRotation(value * 2 * 3.14),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.cardBackground,
                          image: const DecorationImage(
                            image: AssetImage('assets/images/profile.JPG'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),

            // Name and Title with Typing Animation
            const AnimatedText(
              text: 'Abdullahi Burhan',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 10),
            const AnimatedText(
              text: 'Creative Developer',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.textSecondary,
              ),
              delay: Duration(milliseconds: 500),
            ),

            const SizedBox(height: 30),

            // Social Links
            Wrap(
              alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
              children: [
                  _buildSocialButton(
                    Icons.language,
                    'Website',
                    'https://saxansaxotech.com',
                  ),
                  _buildSocialButton(
                    Icons.code,
                    'GitHub',
                    'https://github.com/ABurhaan',
                  ),
                  _buildSocialButton(
                    Icons.business,
                    'LinkedIn',
                    'https://www.linkedin.com/in/abdullahi-burhan-mohamed-8583171b5/',
                  ),
                ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label, String url) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isHovered = false;
      bool isLoading = false;

      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()
            ..scale(isHovered ? 1.1 : 1.0),
          child: TextButton.icon(
            onPressed: isLoading
                ? null
                : () async {
                    setState(() => isLoading = true);
                    try {
                      await _launchUrl(url);
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Could not launch $label'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } finally {
                      setState(() => isLoading = false);
                    }
                  },
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.textPrimary,
                      ),
                    ),
                  )
                : Icon(icon, color: AppColors.textPrimary),
            label: Text(
              label,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
            style: TextButton.styleFrom(
              backgroundColor: AppColors.overlayColor,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      );
    },
  );
}
}