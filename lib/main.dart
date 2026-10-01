import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skilllink_worker/res/colors/app_colors.dart';
import 'package:skilllink_worker/res/getx_localization/languages.dart';
import 'package:skilllink_worker/res/routes/routes.dart';
import 'package:skilllink_worker/res/routes/routes_names.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Make status bar transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SkillLink',
      translations: Languages(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: AppColor.background,
        primaryColor: AppColor.primary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primary,
          primary: AppColor.primary,
          surface: AppColor.cardBackground,
          error: AppColor.red,
        ),
      ),
      initialRoute: RouteName.splashScreen,
      getPages: AppRoutes.appRoutes(),
    );
  }
}
