import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hoc24/app/config/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final double height;
  final double? width;
  final double elevation;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;

  const AppButton({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.height = 32,
    this.width,
    this.elevation = 2,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular((height / 3).ceilToDouble()),
      ),
      color: isLoading ? theme.colorScheme.tertiary : backgroundColor,
      elevation: elevation,
      child: GestureDetector(
        onTap: isLoading ? null : onPressed,
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(vertical: height / 2, horizontal: height),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isLoading) Container(color: Colors.red, width: 50),
              Expanded(
                child: AutoSizeText(
                  text,
                  style: TextStyle(
                    color: isLoading ? AppColors.lightGrey : textColor ?? theme.colorScheme.primary,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (isLoading) const SizedBox(width: 50, child: CupertinoActivityIndicator(color: AppColors.lightGrey)),
            ],
          ),
        ),
      ),
    );
  }
}
