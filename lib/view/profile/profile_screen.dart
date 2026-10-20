import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/components/widgets/profile_header.dart';
import '../../res/components/widgets/profile_menu_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            const ProfileHeader(),

            // Body Options Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  // Availability Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColor.cardBackground,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColor.grey200.withValues(alpha: 0.6)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Icon Box
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F8EE),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(
                            Icons.hexagon_rounded,
                            color: Color(0xFF2ECC71),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Title & Status
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Availability",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                isAvailable
                                    ? "Online • Accepting jobs"
                                    : "Offline • Not accepting jobs",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isAvailable
                                      ? const Color(0xFF2ECC71)
                                      : AppColor.textSecondary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Switch
                        Transform.scale(
                          scale: 0.85,
                          child: Switch(
                            value: isAvailable,
                            onChanged: (val) {
                              setState(() {
                                isAvailable = val;
                              });
                            },
                            activeThumbColor: Colors.white,
                            activeTrackColor: const Color(0xFF2ECC71),
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: AppColor.grey200,
                            trackOutlineColor:
                                WidgetStateProperty.all(Colors.transparent),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Menu Options Card
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColor.cardBackground,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: AppColor.grey200.withValues(alpha: 0.6)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.black.withValues(alpha: 0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ProfileMenuItem(
                          icon: Icons.edit_rounded,
                          iconBgColor: const Color(0xFFEFF6FF),
                          iconColor: const Color(0xFF2563EB),
                          title: "Edit Profile",
                          onTap: () {
                            // Edit profile action
                          },
                        ),
                        ProfileMenuItem(
                          icon: Icons.notifications_rounded,
                          iconBgColor: const Color(0xFFFFF7ED),
                          iconColor: const Color(0xFFF59E0B),
                          title: "Notifications",
                          onTap: () {
                            // Notifications action
                          },
                        ),
                        ProfileMenuItem(
                          icon: Icons.help_outline_rounded,
                          iconBgColor: const Color(0xFFFEF2F2),
                          iconColor: const Color(0xFFEF4444),
                          title: "Help & Support",
                          onTap: () {
                            // Help & Support action
                          },
                        ),
                        ProfileMenuItem(
                          icon: Icons.article_outlined,
                          iconBgColor: const Color(0xFFF3E8FF),
                          iconColor: const Color(0xFF8B5CF6),
                          title: "Terms & Privacy",
                          onTap: () {
                            // Terms & Privacy action
                          },
                        ),
                        ProfileMenuItem(
                          icon: Icons.logout_rounded,
                          iconBgColor: const Color(0xFFFEF2F2),
                          iconColor: const Color(0xFFEF4444),
                          title: "Logout",
                          textColor: const Color(0xFFEF4444),
                          showDivider: false,
                          onTap: () {
                            // Logout action
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // App Version Text
                  Text(
                    "SkillLink Worker v1.0.0",
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColor.textSecondary.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
