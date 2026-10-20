import 'package:flutter/material.dart';
import '../../res/colors/app_colors.dart';
import '../../res/components/widgets/home_header.dart';
import '../../res/components/widgets/request_card.dart';
import '../../res/components/widgets/stat_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Blue Gradient Header
            const HomeHeader(),

            // Main Content Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Row
                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          title: "Total Today",
                          value: "3",
                          icon: Icons.business_center_rounded,
                          iconBgColor: AppColor.primary.withValues(alpha: 0.12),
                          iconColor: AppColor.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          title: "Completed",
                          value: "28",
                          icon: Icons.check_circle_rounded,
                          iconBgColor: AppColor.success.withValues(alpha: 0.12),
                          iconColor: AppColor.success,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: StatCard(
                          title: "Rating",
                          value: "4.8",
                          icon: Icons.star_rounded,
                          iconBgColor: AppColor.warning.withValues(alpha: 0.15),
                          iconColor: AppColor.warning,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Incoming Requests Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Incoming Requests",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textPrimary,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Action for View All
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColor.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "View All",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.primary,
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(
                                Icons.chevron_right_rounded,
                                size: 16,
                                color: AppColor.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Request Card 1: Electrical Repair
                  RequestCard(
                    title: "Electrical Repair",
                    category: "Electrical",
                    location: "Indiranagar, Bengaluru",
                    distance: "1.5 km",
                    badgeText: "Request",
                    icon: Icons.electric_bolt_rounded,
                    description:
                        "Main fuse box is tripping repeatedly. Need urgent inspection and repair ASAP.",
                    onAccept: () {},
                    onDetails: () {},
                    onReject: () {},
                  ),

                  const SizedBox(height: 16),

                  // Request Card 2: Fan Installation
                  RequestCard(
                    title: "Fan Installation",
                    category: "Electrical",
                    location: "HSR Layout, Bengaluru",
                    distance: "1.8 km",
                    badgeText: "Assigned",
                    icon: Icons.air_rounded,
                    description:
                        "Install 2 ceiling fans in bedroom and living room. Wiring already in place.",
                    onAccept: () {},
                    onDetails: () {},
                    onReject: () {},
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
