import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoc24/app/routes/app_pages.dart';
import 'package:hoc24/app/theme/dark_theme.dart';
import 'package:hoc24/app/theme/light_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: Routes.root, // khởi tạo route mặc định
      getPages: AppPages.pages, // khai báo các page route
      routingCallback: routingCallback, // TODO : routingCallback dùng để làm gì ?
      debugShowCheckedModeBanner: false, // dùng để xóa dòng debug
      // supportedLocales: AppLocalizations.supportedLocales,
      // fallbackLocale: const Locale('en', 'UK'),
      theme: lightTheme, // theme mặc định là light
      darkTheme: darkTheme, 
      themeMode: ThemeMode.system,
      // builder: (context, child) {
      //   return MediaQuery(
      //       data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)), child: child!);
      // },
    );
  }
}
