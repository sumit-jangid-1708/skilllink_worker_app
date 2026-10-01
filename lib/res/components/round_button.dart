import 'package:flutter/material.dart';


import '../colors/app_colors.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.loading,
    required this.onPressed,
    required this.title,
    this.textColor = AppColor.white,
    this.buttonColor = AppColor.primary,
    this.buttonWidth = 60,
    this.buttonHeight = 50,
  });

  final bool loading;
  final VoidCallback onPressed;
  final String title;
  final Color textColor, buttonColor;
  final double buttonWidth;
  final double buttonHeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onPressed,
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: loading
            ? const Center(child: CircularProgressIndicator(color: AppColor.white))
            : Center(
            child: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: textColor))),
      ),
    );
  }
}
