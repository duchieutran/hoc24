import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/domain/models/response/dashboard/books_entity.dart';

class BooksCard extends StatelessWidget {
  final BooksEntity booksEntity;
  final String nameSubject;
  final int idSubject;
  const BooksCard({super.key, required this.booksEntity, required this.nameSubject, required this.idSubject});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () => Get.toNamed(
          Routes.categories,
          arguments: {
            'nameSubject': nameSubject,
            'idSubject': idSubject,
            'nameBook': booksEntity.name,
            'idBook': booksEntity.id,
          },
        ),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          height: 140,
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Center(
                  child: Image.asset(
                'assets/subjects/${booksEntity.alias}.png',
                width: 80,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Image.asset("assets/subjects/chuong-trinh-cu.png", width: 80);
                },
              )),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${booksEntity.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(CupertinoIcons.bookmark, color: AppColors.lightGrey, size: 18),
                        Expanded(
                          child: AutoSizeText(
                            '${booksEntity.info?.countChapter} chương',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: text16.textGreyColor.height14Per,
                            minFontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Icon(CupertinoIcons.book, color: AppColors.lightGrey, size: 18),
                        const SizedBox(width: 3),
                        Expanded(
                          child: AutoSizeText(
                            '${booksEntity.info?.countLesson} bài học',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: text16.textGreyColor.height14Per,
                            minFontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate(delay: 0.ms).fadeIn(delay: 1.ms).slideY(begin: 0.1, end: 0);
  }
}
