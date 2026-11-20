import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/colors/app_colors.dart';
import '../../res/components/widgets/home_header.dart';
import '../../res/components/widgets/request_card.dart';
import '../../res/components/widgets/stat_card.dart';
import '../../res/routes/routes_names.dart';
import '../../view_models/controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      backgroundColor: AppColor.background,
      body: Obx(() {
        final stats = controller.dashboard;
        final profile = controller.profile;
        final verified = profile['verification_status'] == 'verified';
        final available = profile['is_available'] == true;
        return RefreshIndicator(
          onRefresh: controller.getHomeData,
          child: ListView(children: [
            HomeHeader(
              userName: (stats['full_name'] ?? 'Technician').toString(),
              isVerified: verified,
              initialOnlineStatus: available,
              onOnlineStatusChanged: controller.updateAvailability,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Expanded(child: StatCard(
                      title: 'Total Today',
                      value: '${stats['jobs_today'] ?? 0}',
                      icon: Icons.business_center_rounded,
                      iconBgColor: AppColor.primary.withValues(alpha: 0.12),
                      iconColor: AppColor.primary,
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: StatCard(
                      title: 'Completed',
                      value: '${stats['total_completed'] ?? 0}',
                      icon: Icons.check_circle_rounded,
                      iconBgColor: AppColor.success.withValues(alpha: 0.12),
                      iconColor: AppColor.success,
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: StatCard(
                      title: 'Rating',
                      value: '${stats['avg_rating'] ?? 0}',
                      icon: Icons.star_rounded,
                      iconBgColor: AppColor.warning.withValues(alpha: 0.15),
                      iconColor: AppColor.warning,
                    )),
                  ]),
                  const SizedBox(height: 24),
                  const Text('Incoming Requests', style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: AppColor.textPrimary,
                  )),
                  const SizedBox(height: 16),
                  if (controller.isLoading.value && controller.incomingRequests.isEmpty)
                    const Center(child: Padding(
                      padding: EdgeInsets.all(24),
                      child: CircularProgressIndicator(),
                    ))
                  else if (!verified)
                    const Center(child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('Your profile is waiting for verification.'),
                    ))
                  else if (!available)
                    const Center(child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('You are offline and not accepting jobs.'),
                    ))
                  else if (controller.incomingRequests.isEmpty)
                    const Center(child: Padding(
                      padding: EdgeInsets.all(24),
                      child: Text('No incoming requests'),
                    ))
                  else
                    ...controller.incomingRequests.map((job) {
                      final id = int.tryParse('${job['id']}') ?? 0;
                      final title = (job['sub_category'] ?? job['skill_category_name'] ?? 'Service request').toString();
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: RequestCard(
                          title: title,
                          category: (job['skill_category_name'] ?? 'Service').toString(),
                          location: (job['city'] ?? job['address'] ?? 'Location unavailable').toString(),
                          distance: (job['urgency'] ?? 'normal').toString(),
                          description: (job['description'] ?? '').toString(),
                          badgeText: (job['status'] ?? 'pending').toString(),
                          onAccept: id == 0 ? null : () => controller.acceptJob(id),
                          onReject: id == 0 ? null : () => controller.rejectJob(id),
                          onDetails: id == 0 ? null : () => Get.toNamed(
                            RouteName.jobDetailsScreen,
                            arguments: {'id': id, 'request': job},
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
          ]),
        );
      }),
    );
  }
}
