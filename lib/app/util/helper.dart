// import 'dart:math';
//
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:slack_notifier/slack_notifier.dart';
// import 'package:tradein/res/style.dart';
// import 'package:tradein/share/libraries/logger/flutter_logger.dart';
// import 'package:tradein/share/libraries/photo_manager/photo_manager.dart';
// import 'package:tradein/utils/environment.dart';
// import 'package:tradein/utils/extention/datetime_extension.dart';
// import 'package:tradein/utils/images.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../app/base_app_config.dart';
// import '../controllers/app_controller.dart';
//
// class Helper {
//   static T2? findItemCallback<T1, T2>(T1? item, List<T2?> items, {bool Function(T1? item1, T2? item2)? cb}) {
//     if (item == null) {
//       return null;
//     }
//     final index = items.indexWhere((e) {
//       if (e.runtimeType != String) {
//         if (cb != null) {
//           return cb(item, e);
//         }
//         return e == item;
//       }
//
//       return e.toString().toLowerCase() == item.toString().toLowerCase();
//     });
//     if (index >= 0) {
//       return items[index];
//     }
//     return null;
//   }
//
//   static String removeSeparator(String value, {String separator = ','}) {
//     return value.replaceAll(RegExp(r','), '');
//   }
//
//   static String formatNumber(String value, {String format = '#,###'}) {
//     try {
//       final f = NumberFormat(format);
//       final number = int.parse(value.replaceAll(f.symbols.GROUP_SEP, '').replaceAll('.0', ''));
//       return f.format(number);
//     } catch (_) {
//       return '';
//     }
//   }
//
//   static String formatCurrency(dynamic value,
//       {String? format = '#,##0.00', String? symbol = 'Baht', String? locale = 'en_US'}) {
//     final formatter = NumberFormat.currency(customPattern: format, locale: locale, symbol: symbol);
//     return formatter.format(value);
//   }
//
//   static String formateDateTime(value) {
//     return DateFormat.yMMMd().add_Hm().format(value);
//   }
//
//   static DateTime? parseDate(String? value) {
//     try {
//       return DateTime.parse(value!).toLocal();
//     } catch (_) {
//       return null;
//     }
//   }
//
//   static showSnackBar(String? content, {String? title, Color? colorText, Color? bgColor}) {
//     if (Get.isSnackbarOpen) {
//       return;
//     }
//     Get.snackbar(title ?? LocalString.notificationError, content ?? LocalString.notificationContent,
//         colorText: colorText ?? Colors.black, backgroundColor: bgColor);
//   }
//
//   static showSuccess(String? content, {String? title, Color? colorText}) {
//     Helper.showSnackBar(content, title: title, colorText: whiteColor, bgColor: Colors.green.shade200);
//   }
//
//   static showError(String? content, {String? title, Color? colorText}) {
//     Helper.showSnackBar(content, title: title, colorText: whiteColor, bgColor: Colors.red.shade200);
//   }
//
//   static Future<void> launchAppByUrl(String url) async {
//     final Uri uri = Uri.parse(url);
//     if (!await launchUrl(uri)) {
//       Helper.showError(LocalString.cannotLaunchUrl.trParams({'name': url}));
//     }
//   }
//
//   static Future<void> launchPhoneCall(String phone) async {
//     if (phone.isEmpty) {
//       Helper.showError(LocalString.customerPhoneIsInvalid);
//       return;
//     }
//     await Helper.launchAppByUrl('tel:$phone');
//   }
//
//   static Future<void> launchMap(String address) async {
//     await Helper.launchAppByUrl('http://maps.apple.com/?address=$address');
//   }
//
//   static int randomNumber({int min = 1, int max = 5}) {
//     Random random = Random();
//     return (random.nextInt(max) + min).round();
//   }
//
//   static List<DateTime> getDaysInMonth() {
//     var firstDayOfMonth = DateTime.now().firstDayOfMonth;
//     var lastDayOfMonth = DateTime.now().lastDayOfMonth;
//     List<DateTime> list = [];
//     // add first day
//     list.add(firstDayOfMonth);
//     while (firstDayOfMonth.isBefore(lastDayOfMonth)) {
//       firstDayOfMonth = firstDayOfMonth.add(const Duration(days: 1));
//       // add day between fisrt day and last day
//       list.add(firstDayOfMonth);
//     }
//     return list;
//   }
//
//   static List<DateTime> getFilterDays({int period = 15}) {
//     var firstDayOfMonth = DateTime.now().subtract(Duration(days: period));
//     var lastDayOfMonth = DateTime.now().add(Duration(days: period));
//     List<DateTime> list = [];
//     // add first day
//     list.add(firstDayOfMonth);
//     while (firstDayOfMonth.isBefore(lastDayOfMonth)) {
//       firstDayOfMonth = firstDayOfMonth.add(const Duration(days: 1));
//       // add day between fisrt day and last day
//       list.add(firstDayOfMonth);
//     }
//     return list;
//   }
//
//   static String get idGenerator => DateTime.now().microsecondsSinceEpoch.toString();
//
//   static Future<String> imagePicker({bool isCrop = false}) async {
//     try {
//       // Note: image_picker package occured error
//       // ---> error low response-> final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//
//       FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(type: FileType.image);
//       // crop image as espected
//       if (pickedFile != null) {
//         var filePath = pickedFile.files.single.path ?? '';
//         if (filePath.isEmpty) {
//           return '';
//         }
//         if (isCrop) {
//           final String? croppedImage = await editPhoto(filePath);
//           return croppedImage ?? '';
//         }
//
//         return await ImageProcessor.compressImage(filePath);
//       }
//       return '';
//     } catch (e, s) {
//       Logger.e(e);
//       Logger.e(s);
//       return '';
//     }
//   }
//
//   static sendSlackMessage({String type = 'Error', String message = '', String detail = ''}) {
//     try {
//       var appCtl = Get.find<AppController>();
//       var slack = SlackNotifier(
//           Environment.getValue('SLACK_TOKEN', defaultFb: 'TEBBFMW5V/B03CB47JXLN/XLbSCQ8GVut9wvm04aFMAwD0'));
//       var env = 'Development';
//       if (appCtl.env == EnvironmentType.prod) {
//         env = 'Production';
//       }
//       if (appCtl.env == EnvironmentType.stg) {
//         env = 'Staging';
//       }
//       var blocks = [
//         DividerBlock(),
//         SectionBlock(text: '*Mobile Application*'),
//         SectionBlock(
//             //     fields: [
//             //   {'type': 'mrkdwn', 'text': '*Environment:* `$env`'},
//             //   {'type': 'mrkdwn', 'text': '*Type:* `$type`'},
//             // ]
//             text: '*Environment:* `$env`\t*Type:* `$type`'),
//         SectionBlock(text: '*Device Info:* ```${appCtl.deviceData.toString()}```'),
//         SectionBlock(text: '*Message:*\n`$message`'),
//         SectionBlock(text: '*Detail:*\n```$detail```'),
//       ];
//       slack.send('Mobile Application', blocks: blocks, channel: '#trade-in-mobile-notifications');
//     } catch (e, s) {
//       Logger.e(e);
//       Logger.e(s);
//     }
//   }
//
//   static Map<String, double> pointToPercent(double x, double y, Size screenSize) {
//     String dx = ((x * 100) / screenSize.width).toStringAsFixed(2);
//     String dy = ((y * 100) / screenSize.height).toStringAsFixed(2);
//     return {'x': double.parse(dx), 'y': double.parse(dy)};
//   }
//
//   static Map<String, double> percentToPoint(double x, double y, Size screenSize) {
//     String dx = ((x * screenSize.width) / 100).toStringAsFixed(2);
//     String dy = ((y * screenSize.height) / 100).toStringAsFixed(2);
//     return {'x': double.parse(dx), 'y': double.parse(dy)};
//   }
// }
