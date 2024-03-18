import 'package:disease_tracker/helpers/app_helper.dart';
import 'package:disease_tracker/screens/splash_screen.dart';
import 'package:disease_tracker/utils/app_dimen.dart';
import 'package:disease_tracker/utils/app_string.dart';
import 'package:disease_tracker/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

Future<void> main() async {
  await AppHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: AppTheme.light,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(FontDimen.textScaleFactor)),
            child: child!);
      },
      home: const SplashScreen(),
    );
  }
}
