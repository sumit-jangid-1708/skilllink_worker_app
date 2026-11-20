import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/colors/app_colors.dart';
import '../../res/components/widgets/profile_header.dart';
import '../../res/components/widgets/profile_menu_item.dart';
import '../../res/routes/routes_names.dart';
import '../../view_models/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Obx(() {
        if (controller.isLoading.value && controller.profile.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        final profile = controller.profile;
        final categoryIds = (profile['skill_categories'] as List? ?? [])
            .map((item) => int.tryParse('$item') ?? -1)
            .toSet();
        final skills = controller.categories
            .where((category) => categoryIds.contains(int.tryParse('${category['id']}')))
            .map((category) => (category['name'] ?? '').toString())
            .where((name) => name.isNotEmpty)
            .toList();
        final name = (profile['full_name'] ?? 'Technician').toString();
        final experience = int.tryParse('${profile['experience_years'] ?? 0}') ?? 0;
        final available = profile['is_available'] == true;
        return RefreshIndicator(
          onRefresh: controller.getProfile,
          child: ListView(children: [
            ProfileHeader(
              initials: _initials(name),
              name: name,
              profession: skills.isEmpty ? 'Technician' : skills.first,
              experience: '$experience Years',
              location: (profile['city'] ?? 'City unavailable').toString(),
              skills: skills,
              jobsCount: '${controller.dashboard['total_completed'] ?? 0}',
              rating: '${controller.dashboard['avg_rating'] ?? '—'}',
              completionRate: '${controller.dashboard['completion_rate'] ?? 0}%',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColor.cardBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColor.grey200.withValues(alpha: 0.6)),
                  ),
                  child: Row(children: [
                    const Icon(Icons.hexagon_rounded, color: Color(0xFF2ECC71)),
                    const SizedBox(width: 14),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Availability', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(available ? 'Online • Accepting jobs' : 'Offline • Not accepting jobs'),
                      ],
                    )),
                    Switch(
                      value: available,
                      onChanged: controller.updateAvailability,
                      activeTrackColor: const Color(0xFF2ECC71),
                    ),
                  ]),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColor.cardBackground,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColor.grey200.withValues(alpha: 0.6)),
                  ),
                  child: Column(children: [
                    ProfileMenuItem(
                      icon: Icons.edit_rounded,
                      iconBgColor: const Color(0xFFEFF6FF),
                      iconColor: const Color(0xFF2563EB),
                      title: 'Edit Profile',
                      onTap: () async {
                        await Get.toNamed(RouteName.editProfileScreen);
                        await controller.getProfile();
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.notifications_rounded,
                      iconBgColor: const Color(0xFFFFF7ED),
                      iconColor: const Color(0xFFF59E0B),
                      title: 'Notifications',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.help_outline_rounded,
                      iconBgColor: const Color(0xFFFEF2F2),
                      iconColor: const Color(0xFFEF4444),
                      title: 'Help & Support',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.article_outlined,
                      iconBgColor: const Color(0xFFF3E8FF),
                      iconColor: const Color(0xFF8B5CF6),
                      title: 'Terms & Privacy',
                      onTap: () {},
                    ),
                    ProfileMenuItem(
                      icon: Icons.logout_rounded,
                      iconBgColor: const Color(0xFFFEF2F2),
                      iconColor: const Color(0xFFEF4444),
                      title: 'Logout',
                      textColor: const Color(0xFFEF4444),
                      showDivider: false,
                      onTap: controller.logout,
                    ),
                  ]),
                ),
                const SizedBox(height: 24),
                Text('SkillLink Worker v1.0.0', style: TextStyle(
                  fontSize: 12, color: AppColor.textSecondary.withValues(alpha: 0.7),
                )),
                const SizedBox(height: 20),
              ]),
            ),
          ]),
        );
      }),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+')).where((part) => part.isNotEmpty).toList();
    if (parts.isEmpty) return 'T';
    return parts.take(2).map((part) => part[0].toUpperCase()).join();
  }
}
