import 'package:flutter/material.dart';
import '../constants/colors.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Experience',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          _buildTimeline(context),
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return Column(
      children: [
        _buildTimelineItem(
          year: '2023-Present',
          title: 'Senior Developer',
          company: 'Saxansaxo Tech',
          description: 'Led development of multiple mobile applications using Flutter, Django & Supabase',
          isFirst: true,
        ),
        _buildTimelineItem(
          year: '2022-Present',
          title: 'IT Support Specialist',
          company: 'Amal Bank',
          description: 'provided technical support by installing and configuring hardware to optimize system performance and supporting technology upgrades. Conducted regular system maintenance, including data backups and asset protection, to ensure effective operations. Assisted in the rollout of new software versions by performing beta testing and troubleshooting issues. Managed inventory updates, databases, and internal information systems to support senior management. Addressed user queries and technical issues, ensuring adherence to IT policies and procedures.',
        ),
        
        _buildTimelineItem(
          year: '2020-Present',
          title: 'Bank Teller',
          company: 'Amal Bank',
          description: "Responsibilities included processing customer deposits, withdrawals, and payments, while ensuring compliance with bank policies and procedures. Provided exceptional customer service by addressing client inquiries and resolving transaction-related issues. Maintained cash drawer balance and conducted daily reconciliations to ensure accurate financial reporting. Supported branch operations by assisting in fraud prevention, handling cash-related discrepancies, and ensuring a secure and organized working environment.",
        ),
        _buildTimelineItem(
          year: '2020',
          title: 'Junior Developer',
          company: 'Saxansaxo Tech',
          description: 'Worked on various frontend projects.',
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String year,
    required String title,
    required String company,
    required String description,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          // Timeline line and dot
          SizedBox(
            width: 40,
            child: Column(
              children: [
                if (!isFirst)
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 2,
                      color: AppColors.accent,
                    ),
                  ),
                Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.secondary,
                      width: 3,
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 2,
                      color: AppColors.accent,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          // Content
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(20),
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
                  Text(
                    year,
                    style: TextStyle(
                      color: AppColors.accent,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    company,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}