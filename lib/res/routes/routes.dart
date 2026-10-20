import 'package:get/get.dart';
import '../../view/auth/login_screen.dart';
import '../../view/dashboard/dashboard.dart';
import '../../view/home/home_screen.dart';
import '../../view/jobs/jobs_screen.dart';
import '../../view/profile/profile_screen.dart';
import '../../view/splash_screen/splash_screen.dart';
import 'routes_names.dart';

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
    GetPage(
      name: RouteName.dashboardScreen,
      page: () => const Dashboard(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: RouteName.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: RouteName.jobsScreen,
      page: () => const JobsScreen(),
    ),
    GetPage(
      name: RouteName.profileScreen,
      page: () => const ProfileScreen(),
    ),
  ];
}
