import 'package:flutter/material.dart';
import '../res/colors/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String location;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;

  const CustomAppBar({
    super.key,
    required this.name,
    required this.location,
    this.onProfileTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            // Profile Image
            GestureDetector(
              onTap: onProfileTap,
              child: Container(
                width: 45,
                height: 45,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.white,
                  image: DecorationImage(
                    image: AssetImage("assets/images/avatar.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Name and Location
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColor.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        location,
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppColor.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down, size: 20, color: AppColor.textPrimary),
                    ],
                  ),
                ],
              ),
            ),
            // Notification Box
            GestureDetector(
              onTap: onNotificationTap,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primary,
                ),
                child: const Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.notifications_none_rounded,
                      color: AppColor.white,
                      size: 24,
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: CircleAvatar(
                        radius: 4,
                        backgroundColor: AppColor.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
