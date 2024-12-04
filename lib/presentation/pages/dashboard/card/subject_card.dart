import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/domain/models/response/dashboard/subject_entity.dart';

class SubjectCard extends StatelessWidget {
  final SubjectEntity subjectEntity;
  final Function(String?, int?) onTap;

  const SubjectCard({
    super.key,
    required this.subjectEntity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(subjectEntity.name, subjectEntity.id),
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(2),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: AppColors.colorList[(subjectEntity.id ?? 0) % 10],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  subjectEntity.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: text20.bold.textLightColor,
                  minFontSize: 16,
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.dark.withOpacity(0.2),
                  ),
                  child: Text(
                    '${subjectEntity.books?.length} bộ sách',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: text12.bold.textLightColor,
                  ),
                ),
                const Spacer(),
                Center(
                    child: Image.asset(
                  'assets/subjects/${subjectEntity.alias}.png',
                  width: 60,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image.asset("assets/subjects/ngu-van.png", width: 60);
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
