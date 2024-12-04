import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hoc24/app/config/app_text.dart';
import 'package:hoc24/app/types/sort_type.dart';
import 'package:hoc24/domain/models/response/dashboard/user_boards_entity.dart';
import 'package:hoc24/presentation/widgets/app_avatar.dart';

class UserBoardsCard extends StatelessWidget {
  final UserBoardNode userBoard;
  final SortType sortType;
  final int index;
  final VoidCallback onTap;

  const UserBoardsCard({
    super.key,
    required this.userBoard,
    required this.sortType,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String getScores() {
      switch (sortType) {
        case SortType.sweek:
          return '${userBoard.sweek} GP';
        case SortType.smonth:
          return '${userBoard.smonth} GP';
        case SortType.summAll:
          return '${userBoard.sumAll} GP';
        default:
          return '';
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Center(
                child: AutoSizeText(
                  '${index + 1}',
                  style: theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: AppAvatar(
                  name: userBoard.userEntity?.name ?? '',
                  radius: 16,
                  url: userBoard.userEntity?.images ?? '',
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Text(
                userBoard.userEntity?.name ?? '',
                style: theme.textTheme.bodyMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 4,
              child: Center(
                child: Container(
                  height: 22,
                  decoration:
                      BoxDecoration(color: theme.colorScheme.secondary, borderRadius: BorderRadius.circular(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Center(
                        child: AutoSizeText(
                          getScores(),
                          style: text12.bold.textLightColor,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
