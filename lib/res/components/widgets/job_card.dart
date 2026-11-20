import 'package:flutter/material.dart';
import '../../colors/app_colors.dart';

class JobCard extends StatelessWidget {
  final String title;
  final String customerName;
  final String dateTime;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String statusText;
  final Color statusBgColor;
  final Color statusTextColor;
  final VoidCallback? onTap;

  const JobCard({
    super.key,
    required this.title,
    required this.customerName,
    required this.dateTime,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    this.statusText = "Done",
    this.statusBgColor = const Color(0xFFDCFCE7),
    this.statusTextColor = const Color(0xFF16A34A),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.grey200.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Row(
          children: [
            // Icon Container Box
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 26,
              ),
            ),
            const SizedBox(width: 14),

            // Middle Info Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    customerName,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColor.textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: AppColor.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dateTime,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColor.textSecondary,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Status Badge (Done / Completed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: statusBgColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: statusTextColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    statusText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: statusTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
