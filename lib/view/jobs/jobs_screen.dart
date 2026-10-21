import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/colors/app_colors.dart';
import '../../res/components/widgets/request_card.dart';
import '../../view_models/controller/jobs_controller.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobsController());

    return Scaffold(
      backgroundColor: AppColor.background,
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 30),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColor.primary, Color(0xFF6366F1)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Jobs",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Track and manage all your assigned services here.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Filters Tab Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColor.cardBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColor.grey200.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              // REMOVED outer Obx from here
              child: Row(
                children: [
                  _buildFilterButton("Active", controller),
                  _buildFilterButton("Pending", controller),
                  _buildFilterButton("Complete", controller),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Jobs List View
          Expanded(
            child: Obx(() {
              // Access the observable value at the top level of Obx
              final String status = controller.selectedFilter.value;
              
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                itemCount: 3, 
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildJobCard(status),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String title, JobsController controller) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.setFilter(title),
        child: Obx(() {
          final bool isSelected = controller.selectedFilter.value == title;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppColor.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? Colors.white : AppColor.textSecondary,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildJobCard(String status) {
    if (status == "Active") {
      return const RequestCard(
        title: "AC Deep Cleaning",
        category: "Appliances",
        location: "Koramangala 4th Block",
        distance: "1.2 km",
        badgeText: "Active",
        badgeColor: Color(0xFFE8F0FE),
        badgeTextColor: AppColor.primary,
        icon: Icons.ac_unit_rounded,
        description: "General service and deep cleaning of split AC unit.",
      );
    } else if (status == "Pending") {
      return const RequestCard(
        title: "Water Purifier Fix",
        category: "Appliances",
        location: "Jayanagar 5th Block",
        distance: "3.5 km",
        badgeText: "Pending",
        badgeColor: Color(0xFFFFF7ED),
        badgeTextColor: Colors.orange,
        icon: Icons.water_drop_rounded,
        description: "Filter replacement and general checkup.",
      );
    } else {
      return const RequestCard(
        title: "Ceiling Fan Fitting",
        category: "Electrical",
        location: "BTM Layout",
        distance: "2.8 km",
        badgeText: "Complete",
        badgeColor: Color(0xFFE8F8EE),
        badgeTextColor: Colors.green,
        icon: Icons.toys_rounded,
        description: "Successfully installed 2 new ceiling fans.",
      );
    }
  }
}
