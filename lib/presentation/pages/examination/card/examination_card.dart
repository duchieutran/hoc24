import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/domain/models/response/dashboard/examination_entity.dart';

class ExaminationCard extends StatelessWidget {
  final ExaminationNode examination;
  final VoidCallback onTap;

  const ExaminationCard({
    super.key,
    required this.examination,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: InkWell(
          onTap: onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${examination.title}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.subject, color: AppColors.lightGrey, size: 20),
                    const SizedBox(width: 3),
                    Expanded(
                      child: AutoSizeText(
                        ' ${examination.subjectEntity?.name} lớp ${examination.idGrade}',
                        style: text16.textGreyColor.height14Per,
                        minFontSize: 16,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.watch_later_outlined, color: AppColors.lightGrey, size: 20),
                    const SizedBox(width: 3),
                    Text(
                      '${examination.time} phút',
                      style: text16.textGreyColor.height14Per,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate(delay: 0.ms).fadeIn(delay: 1.ms).slideY(begin: 0.2, end: 0);
  }
}
