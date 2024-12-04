import 'package:get/get.dart';
import 'package:hoc24/app/logger/flutter_logger.dart';
import 'package:hoc24/data/providers/network/apis/exceptions/data_exception.dart';

import 'snack_bar_helper.dart';

class HandleExceptionHelper {
  static DataException? dataException;

  static void rest(e, s) {
    Logger.e(e);
    Logger.e(s);
    showErrors(e.toString().tr);
  }

  static void showErrors(Object exception) {
    if (exception is DataException) {
      dataException = exception;
    }
    Logger.e('Response Exception: $exception');

    if (Get.isSnackbarOpen) {
      return;
    }
    SnackBarHelper.errorSnackBar(dataException?.message ??
        (exception.toString().isNotEmpty ? exception.toString() : 'Error connecting to server'));
  }

  static void graphql(error) {
    Logger.e('Response Exception: $error');
    if (Get.isSnackbarOpen) {
      return;
    }
    SnackBarHelper.errorSnackBar(error.toString());
  }
}
