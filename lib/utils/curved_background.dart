import 'package:flutter/material.dart';
import '../res/colors/app_colors.dart';

class CurvedBackground extends StatelessWidget {
  final Widget child;

  const CurvedBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.primaryDark,
            AppColor.primary,
            AppColor.background,
          ],
        ),
      ),
      child: child,
    );
  }
}
