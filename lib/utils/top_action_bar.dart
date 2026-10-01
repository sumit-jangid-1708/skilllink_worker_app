import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../res/colors/app_colors.dart';

class TopActionBar extends StatelessWidget {
  final IconData leftIcon;
  final VoidCallback? onLeftTap;
  final IconData rightIcon;
  final VoidCallback? onRightTap;
  final bool showNotificationDot;
  final Color backgroundColor;
  final Color iconColor;

  const TopActionBar({
    super.key,
    required this.leftIcon,
    this.onLeftTap,
    required this.rightIcon,
    this.onRightTap,
    this.showNotificationDot = false,
    this.backgroundColor = AppColor.white,
    this.iconColor = AppColor.textPrimary,
  });

  @override
  Widget build(BuildContext context) {
    Widget buildIconButton(IconData icon, VoidCallback? onTap, {bool showDot = false}) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, color: iconColor, size: 24),
              if (showDot)
                Positioned(
                  right: 12,
                  top: 12,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColor.red,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildIconButton(leftIcon, onLeftTap ?? () => Get.back()),
        buildIconButton(rightIcon, onRightTap, showDot: showNotificationDot),
      ],
    );
  }
}
