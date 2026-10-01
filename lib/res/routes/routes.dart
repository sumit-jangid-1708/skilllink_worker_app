import 'package:get/get.dart';
import '../../view/auth/login_screen.dart';
import '../../view/splash_screen/splash_screen.dart';
import 'routes_names.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static List<GetPage> appRoutes() => [
    GetPage(
      name: RouteName.splashScreen,
      page: () => const SplashScreen(),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: RouteName.loginScreen,
      page: () => const LoginScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    // Placeholder for Dashboard/Home if they don't exist yet
    GetPage(
      name: RouteName.dashboardScreen,
      page: () => const Scaffold(body: Center(child: Text("Dashboard"))),
    ),
    GetPage(
      name: RouteName.homeScreen,
      page: () => const Scaffold(body: Center(child: Text("Home"))),
    ),
  ];
}
