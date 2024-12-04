import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hoc24/presentation/app.dart';
import 'presentation/controllers/app_controller.dart';

void main() async {
  // dùng để thực hiện các logic dữ liệu cần thiết trước khi hoàn thành giao diện
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  // dùng để build giao diện dọc
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initServices();
  runApp(const App());
}

initServices() async {
  await Get.put<AppController>(AppController(), permanent: true).init();
}
