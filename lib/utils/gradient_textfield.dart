import "package:flutter/material.dart";
import '../res/colors/app_colors.dart';

class GradientTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;

  const GradientTextField({
    super.key,
    required this.hintText,
    required this.obscureText,
    this.controller,
    required this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.9,
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.grey200),
      ),
      // decoration: BoxDecoration(
      //   gradient: const LinearGradient(colors: [
      //     // AppColor.primaryLight,
      //     AppColor.primary,
      //   ],
      //   begin: Alignment.topLeft,
      //     end: Alignment.bottomRight
      //   ),
      //   borderRadius: BorderRadius.circular(12),
      // ),
      child: Container(
        margin: const EdgeInsets.all(1.8),
        decoration: BoxDecoration(
          color: AppColor.cardBackground,
          borderRadius: BorderRadius.circular(11),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 16, color: AppColor.textPrimary),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColor.textHint),
            prefixIcon:
            prefixIcon != null
                ? Icon(prefixIcon, color: AppColor.primary)
                : null,
            suffixIcon:
            suffixIcon != null
                ? GestureDetector(
              onTap: onSuffixTap,
              child: Icon(suffixIcon, color: AppColor.primary),
            )
                : null,
            filled: true,
            fillColor: AppColor.cardBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
          ),
        ),
      ),
    );
  }
}
