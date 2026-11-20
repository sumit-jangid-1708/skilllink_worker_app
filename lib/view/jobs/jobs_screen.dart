import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/colors/app_colors.dart';
import '../../res/components/widgets/job_card.dart';
import '../../res/routes/routes_names.dart';
import '../../view_models/controller/jobs_controller.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobsController());
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Column(children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B51E5), Color(0xFF2563EB), Color(0xFF3B82F6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
          ),
          padding: EdgeInsets.only(top: topPadding + 20, left: 20, right: 20, bottom: 24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Job History', style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white,
            )),
            const SizedBox(height: 4),
            Obx(() => Text('${controller.jobs.length} completed jobs', style: TextStyle(
              fontSize: 14, color: Colors.white.withValues(alpha: 0.85),
            ))),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
              ),
              child: Obx(() => Row(children: [
                _buildHeaderFilterChip('All', controller.selectedFilter.value == 'All', () => controller.setFilter('All')),
                _buildHeaderFilterChip('This Week', controller.selectedFilter.value == 'This Week', () => controller.setFilter('This Week')),
                _buildHeaderFilterChip('This Month', controller.selectedFilter.value == 'This Month', () => controller.setFilter('This Month')),
              ])),
            ),
          ]),
        ),
        Expanded(child: Obx(() {
          if (controller.isLoading.value && controller.jobs.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.jobs.isEmpty) {
            return const Center(child: Text('No completed jobs'));
          }
          return RefreshIndicator(
            onRefresh: controller.getJobs,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: controller.jobs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final job = controller.jobs[index];
                final id = int.tryParse('${job['id']}') ?? 0;
                final date = (job['completed_at'] ?? job['scheduled_at'] ?? job['created_at'] ?? '').toString();
                return JobCard(
                  title: (job['sub_category'] ?? job['skill_category_name'] ?? 'Service request').toString(),
                  customerName: (job['request_id'] ?? 'Request #$id').toString(),
                  dateTime: date.isEmpty ? 'Date unavailable' : date.replaceFirst('T', ' '),
                  icon: Icons.build_rounded,
                  iconBgColor: const Color(0xFFEBF2FF),
                  iconColor: AppColor.primary,
                  statusText: (job['status'] ?? 'completed').toString(),
                  onTap: id == 0 ? null : () => Get.toNamed(
                    RouteName.jobDetailsScreen,
                    arguments: {'id': id},
                  ),
                );
              },
            ),
          );
        })),
      ]),
    );
  }

  Widget _buildHeaderFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Text(label, style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? AppColor.primary : Colors.white,
          )),
        ),
      ),
    );
  }
}
