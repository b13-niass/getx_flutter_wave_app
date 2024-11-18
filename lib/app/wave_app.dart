import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_wave_app/app/routes/app_pages.dart';
import 'package:getx_wave_app/core/theme/theme.dart';

class WaveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Wave App",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}