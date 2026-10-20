import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/colors/app_colors.dart';
import '../../view_models/controller/dashboard_controller.dart';
import '../home/home_screen.dart';
import '../jobs/jobs_screen.dart';
import '../profile/profile_screen.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController controller = Get.put(DashboardController());

    final List<Widget> pages = const [
      HomeScreen(),
      JobsScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Obx(() => IndexedStack(
        index: controller.selectedIndex.value,
        children: pages,
      )),
      bottomNavigationBar: _buildBottomNavigationBar(context, controller),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, DashboardController controller) {
    final primaryColor = AppColor.primary;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 8, left: 16, right: 16),
          child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                label: "Home",
                activeIcon: Icons.home_rounded,
                inactiveIcon: Icons.home_outlined,
                isSelected: controller.selectedIndex.value == 0,
                onTap: () => controller.changeIndex(0),
                primaryColor: primaryColor,
              ),
              _buildNavItem(
                label: "Jobs",
                activeIcon: Icons.assignment_rounded,
                inactiveIcon: Icons.assignment_outlined,
                isSelected: controller.selectedIndex.value == 1,
                onTap: () => controller.changeIndex(1),
                primaryColor: primaryColor,
              ),
              _buildNavItem(
                label: "Profile",
                activeIcon: Icons.person_rounded,
                inactiveIcon: Icons.person_outline_rounded,
                isSelected: controller.selectedIndex.value == 2,
                onTap: () => controller.changeIndex(2),
                primaryColor: primaryColor,
              ),
            ],
          )),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required String label,
    required IconData activeIcon,
    required IconData inactiveIcon,
    required bool isSelected,
    required VoidCallback onTap,
    required Color primaryColor,
  }) {
    final inactiveColor = const Color(0xFF7C828A);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              color: isSelected ? primaryColor : inactiveColor,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? primaryColor : inactiveColor,
              ),
            ),
            const SizedBox(height: 6),
            // Active indicator line
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              width: isSelected ? 24 : 0,
              decoration: BoxDecoration(
                color: isSelected ? primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
