import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/config/app_colors.dart';

class SnackBarHelper {
  // Usage: SnackbarHelper.successSnackbar('message', title: 'Success');
  static void successSnackBar(
    String message, {
    String title = 'Success',
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.TOP,
  }) {
    Get.snackbar(
      title,
      message,
      colorText: AppColors.dark,
      duration: duration,
      snackPosition: position,
      icon: const Icon(
        Icons.check_circle_rounded,
        size: 32,
        color: Colors.green,
      ),
      backgroundColor: Colors.green.shade50,
    );
  }

  // Usage: SnackbarHelper.errorSnackbar('message', title: 'Error');
  static void errorSnackBar(
    String message, {
    String title = 'Error',
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.TOP,
  }) {
    Get.snackbar(
      title,
      message.isNotEmpty ? message : 'Error connecting to server',
      colorText: AppColors.dark,
      duration: duration,
      snackPosition: position,
      icon: const Icon(
        Icons.cancel,
        size: 32,
        color: Colors.red,
      ),
      backgroundColor: Colors.red.shade50,
    );
  }

  // Usage: SnackbarHelper.warningSnackbar('message', title: 'Warning');
  static void warningSnackBar(
    String message, {
    String title = 'Warning',
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.TOP,
  }) {
    Get.snackbar(
      title,
      message,
      colorText: AppColors.dark,
      duration: duration,
      snackPosition: position,
      icon: const Icon(
        Icons.warning_rounded,
        size: 32,
        color: Colors.amber,
      ),
      backgroundColor: Colors.amber.shade50,
    );
  }
}
