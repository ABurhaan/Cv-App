import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Projects',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : 
                          MediaQuery.of(context).size.width > 600 ? 2 : 1,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: const [
              ProjectCard(
                title: 'School App',
                description: 'A Small App For schools to manage their data',
                icon: Icons.shopping_bag,
                technologies: ['Flutter', 'Supabase',],
              ),
              ProjectCard(
                title: 'Xisaabtan',
                description: 'Financial App for the small businesses and also Big ones',
                icon: Icons.money,
                technologies: ['Flutter', 'Django', 'SQLlite', 'Rest API'],
              ),
              ProjectCard(
                title: 'Hotel Management System',
                description: 'Modern System for Hotels Which has both Web and App',
                icon: Icons.chat,
                technologies: ['Flutter', 'Python', 'Rest API'],
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final List<String> technologies;

  const ProjectCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.technologies,
  }) : super(key: key);

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, isHovered ? -10.0 : 0.0, 0.0),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: isHovered 
                ? AppColors.accent.withOpacity(0.3)
                : AppColors.shadowColor,
              blurRadius: isHovered ? 20 : 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      widget.icon,
                      size: 40,
                      color: AppColors.accent,
                    ),
                    const SizedBox(height: 15),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.description,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.technologies.map((tech) {
                        return Chip(
                          label: Text(
                            tech,
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 12,
                            ),
                          ),
                          backgroundColor: AppColors.overlayColor,
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              if (isHovered)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                    ),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement project details navigation
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('View Details'),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}