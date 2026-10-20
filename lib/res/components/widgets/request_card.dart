import 'package:flutter/material.dart';
import '../../colors/app_colors.dart';

class RequestCard extends StatelessWidget {
  final String title;
  final String category;
  final String location;
  final String distance;
  final String description;
  final String badgeText;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final IconData icon;
  final VoidCallback? onAccept;
  final VoidCallback? onDetails;
  final VoidCallback? onReject;

  const RequestCard({
    super.key,
    this.title = "Electrical Repair",
    this.category = "Electrical",
    this.location = "Indiranagar, Bengaluru",
    this.distance = "1.5 km",
    this.description =
        "Main fuse box is tripping repeatedly. Need urgent inspection and repair ASAP.",
    this.badgeText = "Request",
    this.badgeColor,
    this.badgeTextColor,
    this.icon = Icons.electric_bolt_rounded,
    this.onAccept,
    this.onDetails,
    this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final bool isAssigned = badgeText.toLowerCase() == "assigned";

    final Color effectiveBadgeBg = badgeColor ??
        (isAssigned
            ? const Color(0xFFFFF3E0)
            : AppColor.red.withValues(alpha: 0.08));

    final Color effectiveBadgeText = badgeTextColor ??
        (isAssigned ? const Color(0xFFE65100) : AppColor.red.withValues(alpha: 0.85));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.grey200.withValues(alpha: 0.7)),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header Row: Icon + Title/Category/Location + Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Icon Container
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColor.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: AppColor.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),

              // Title, Subtitle & Location Details
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
                    const SizedBox(height: 2),
                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColor.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Location & Distance Row
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          size: 15,
                          color: AppColor.primary,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            location,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.access_time_rounded,
                          size: 15,
                          color: AppColor.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          distance,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Top Right Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: effectiveBadgeBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  badgeText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: effectiveBadgeText,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // Description Card Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColor.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Color(0xFF4B5563),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Action Buttons Row (Accept, Details, Reject)
          Row(
            children: [
              // Accept Button
              Expanded(
                child: SizedBox(
                  height: 44,
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      foregroundColor: AppColor.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_rounded,
                            size: 20, color: AppColor.white),
                        SizedBox(width: 6),
                        Text(
                          "Accept",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Details Button
              SizedBox(
                height: 44,
                child: OutlinedButton(
                  onPressed: onDetails,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColor.white,
                    foregroundColor: AppColor.primaryDark,
                    side: const BorderSide(color: AppColor.grey200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  child: const Text(
                    "Details",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Reject Button (Red Cross)
              SizedBox(
                width: 44,
                height: 44,
                child: OutlinedButton(
                  onPressed: onReject,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColor.white,
                    foregroundColor: AppColor.red,
                    side: const BorderSide(color: AppColor.grey200),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: Color(0xFFFF4D4D),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
